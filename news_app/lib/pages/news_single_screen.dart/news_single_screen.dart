import 'package:flutter/material.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';
import 'package:test_app/widgets/image_sliver_app_bar.dart';

class NewsSingleScreen extends StatelessWidget {
  final News news;
  const NewsSingleScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ImageSliverAppBar(
            imageUrl: news.imageUrl,
            title: news.title,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList.separated(
              itemBuilder: (contex, i) => news.content[i].startsWith("http")
                  ? SizedBox(
                      height: 155,
                      child: ClipRRect(
                        borderRadius: primaryBR,
                        child: Image.network(
                          news.content[i],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Text(
                      news.content[i],
                      style: NewsTextTheme.regular16.copyWith(color: NewsColors.textPrimary),
                    ),
              itemCount: news.content.length,
              separatorBuilder: (_, __) => const SizedBox(height: 28),
            ),
          )
        ],
      ),
    );
  }
}
