import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/themes/br.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/themes/text_theme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, this.onTap, required this.title});

  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: primaryBR,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(12),
        child: Text(
          title,
          style: NewsTextTheme.headerRegular18.copyWith(color: NewsColors.textPrimary, height: 1.5),
        ),
      ),
    );
  }
}
