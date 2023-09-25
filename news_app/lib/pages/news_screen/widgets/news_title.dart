import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_app/themes/text_theme.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Text(
        title,
        style: NewsTextTheme.headerLightItalic28,
      ),
    );
  }
}
