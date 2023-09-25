import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/themes/color_pallete.dart';

class CenterIndicator extends StatelessWidget {
  final double height;
  const CenterIndicator({super.key, this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: const CircularProgressIndicator(
        color: NewsColors.textPrimary,
      ),
    );
  }
}
