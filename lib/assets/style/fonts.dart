import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle baseStyle = const TextStyle(
    fontFamily: 'JGaegujaengyi',
    fontSize: 16,
    height: 1,
  );

  static TextStyle titleStyle = baseStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
}
