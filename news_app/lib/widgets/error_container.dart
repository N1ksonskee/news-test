import 'package:flutter/material.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';

class ErrorContainer extends StatelessWidget {
  final String error;
  final double height;
  const ErrorContainer({super.key, required this.error, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        error,
        style: NewsTextTheme.regular16.copyWith(color: NewsColors.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
