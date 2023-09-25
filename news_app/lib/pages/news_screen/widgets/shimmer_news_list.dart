import 'package:flutter/material.dart';
import 'package:test_app/pages/news_screen/widgets/shimmer_news_item.dart';

class ShimmerNewsList extends StatelessWidget {
  const ShimmerNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      shrinkWrap: true,
      itemBuilder: (context, i) => const ShimmerNewsTile(),
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
    );
  }
}
