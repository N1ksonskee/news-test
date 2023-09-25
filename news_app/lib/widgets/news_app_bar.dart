import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/themes/assets.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';

const double TOP_OFFSET = 27;

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsAppBar({
    Key? key,
    this.onPressed,
    this.actions,
    this.imageUrl,
    this.title,
    this.backColor = NewsColors.textPrimary,
  }) : super(key: key);

  final Color backColor;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final String? imageUrl;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: NewsColors.bg,
      actions: [...?actions?.map((a) => Padding(padding: const EdgeInsets.only(top: TOP_OFFSET), child: a))],
      leading: Container(
        padding: const EdgeInsets.only(top: TOP_OFFSET),
        width: 50,
        height: 50,
        child: InkWell(
          borderRadius: primaryBR,
          onTap: () => onPressed == null ? GoRouter.of(context).pop() : onPressed!(),
          child: SvgPicture.asset(
            NewsAssets.backButton,
            color: backColor,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      flexibleSpace: imageUrl == null
          ? null
          : Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: 48,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80, // dots space
                    child: Text(
                      title ?? "",
                      maxLines: 2,
                      style: NewsTextTheme.headerLightItalic28.copyWith(
                        color: NewsColors.cardPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(imageUrl == null ? 80 : 495);
}
