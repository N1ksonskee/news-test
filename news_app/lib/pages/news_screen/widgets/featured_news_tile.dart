import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/navigation/routes.dart';
import 'package:test_app/themes/assets.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';

class FeaturedNewsTile extends StatelessWidget {
  final News news;
  final double height;
  final VoidCallback onTap;

  const FeaturedNewsTile({super.key, required this.news, required this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 56;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: primaryBR,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(news.imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 20,
                child: SizedBox(
                  width: width - 40, // dots space
                  child: Text(
                    news.title,
                    maxLines: 2,
                    style: NewsTextTheme.headerLightItalic28.copyWith(
                      color: NewsColors.cardPrimary,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              if (news.isRead)
                Positioned(
                  top: 15,
                  right: 10,
                  child: SvgPicture.asset(
                    NewsAssets.read,
                    width: 15,
                    height: 15,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
