import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:jobmoim/assets/style/colors.dart';

class JmButton extends StatelessWidget {
  const JmButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = Colors.blue, // 기본 색상
    this.textColor = Colors.white, // 기본 텍스트 색상
    this.borderRadius = 8.0, // 기본 라운드 값
    this.height = 48.0, // 기본 높이
    this.width, // 사용자 지정 너비 (null이면 무한대)
    this.fontSize = 16.0, // 기본 폰트 크기
  });

  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double? width;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: kIsWeb && onPressed != null
          ? SystemMouseCursors.click // 웹 환경에서만 pointer로 설정
          : SystemMouseCursors.basic,
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: onPressed != null
                ? color
                : CustomColors.disabled, // 비활성화 상태 색상 처리
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: textColor,
              )),
        ),
      ),
    );
  }
}
