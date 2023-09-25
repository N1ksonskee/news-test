import 'package:flutter/material.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/widgets/shimmer_widget.dart';

class ShimmerNewsTile extends StatelessWidget {
  const ShimmerNewsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                child: const ShimmerWidget.rectangular(height: 60),
              ),
            ),
            const SizedBox(width: 24),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerWidget.rectangular(height: 20),
                  SizedBox(height: 7),
                  ShimmerWidget.rectangular(
                    height: 15,
                    width: 70,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
