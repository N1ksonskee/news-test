import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:test_app/extensions/time_ago.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/navigation/routes.dart';
import 'package:test_app/themes/assets.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({super.key, required this.news, required this.onTap});

  final News news;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: secondaryBR,
          splashColor: NewsColors.cardPressed,
          highlightColor: NewsColors.cardPressed,
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: NewsColors.cardPrimary,
              borderRadius: secondaryBR,
              boxShadow: [
                const BoxShadow(blurRadius: 8, offset: Offset(-4, -4), color: Colors.white),
                BoxShadow(blurRadius: 20, offset: const Offset(4, 4), color: NewsColors.textSecondary.withOpacity(0.1)),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: primaryBR,
                    child: Image.network(news.imageUrl),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        news.title,
                        maxLines: 2,
                        style: NewsTextTheme.regular16.copyWith(
                          color: NewsColors.textPrimary,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        DateTime.parse(news.createdAt).timeAgo(),
                        style: NewsTextTheme.subtitle.copyWith(color: NewsColors.textSecondary),
                      ),
                    ],
                  ),
                )
              ],
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
            ),
          )
      ],
    );
  }
}
