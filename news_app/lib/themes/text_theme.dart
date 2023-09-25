import "package:flutter/material.dart";

abstract class NewsTextTheme {
  static const TextStyle regular16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.02,
  );

  static const TextStyle headerLightItalic20 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 16,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.02,
  );

  static const TextStyle headerLightItalic28 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 28,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.02,
  );

  static const TextStyle headerRegular18 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    letterSpacing: 0.02,
  );

  static const TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.02,
  );
}
