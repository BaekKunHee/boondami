import 'package:flutter/material.dart';

class BMText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;

  const BMText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
  });

  // 제목용 텍스트
  factory BMText.title(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return BMText(
      text,
      key: key,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
      textAlign: textAlign,
    );
  }

  // 부제목용 텍스트
  factory BMText.subtitle(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return BMText(
      text,
      key: key,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      textAlign: textAlign,
    );
  }

  // 본문용 텍스트
  factory BMText.body(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return BMText(
      text,
      key: key,
      fontSize: 14,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  // 작은 텍스트
  factory BMText.small(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return BMText(
      text,
      key: key,
      fontSize: 12,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        decoration: decoration,
        height: height,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
