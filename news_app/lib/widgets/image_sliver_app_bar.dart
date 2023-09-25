import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/themes/assets.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';
import 'package:test_app/widgets/news_app_bar.dart';

class ImageSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backColor;
  final String imageUrl;
  const ImageSliverAppBar({
    super.key,
    required this.title,
    this.onPressed,
    required this.imageUrl,
    this.backColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 495,
      toolbarHeight: 80,
      leading: Container(
        padding: const EdgeInsets.only(top: TOP_OFFSET),
        width: 50,
        height: 50,
        child: InkWell(
          borderRadius: primaryBR,
          onTap: () => onPressed == null ? GoRouter.of(context).pop() : onPressed!(),
          child: Ink(
            width: 50,
            height: 50,
            child: SvgPicture.asset(
              NewsAssets.backButton,
              color: backColor,
              width: 50,
              height: 50,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(vertical: 35, horizontal: 48).copyWith(top: 0),
        expandedTitleScale: 1,
        title: Text(
          title,
          maxLines: 2,
          style: NewsTextTheme.headerLightItalic28.copyWith(
            color: NewsColors.cardPrimary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
