import 'package:flutter/material.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/assets/style/fonts.dart';

class BMInput extends StatelessWidget {
  const BMInput({
    super.key,
    this.label = '',
    this.hintText = '',
    this.borderWidth = 2.0,
    this.borderRadius = 12.0,
    this.controller,
  });

  final String label;
  final String hintText;
  final double borderWidth;
  final double borderRadius;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyles.baseStyle.copyWith(
              color: CustomColors.primary100,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: CustomColors.primary70,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: CustomColors.primary50,
                width: borderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: CustomColors.primary50, // 활성 상태 테두리 색상
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: CustomColors.primary50, // 포커스 상태 테두리 색상
                width: borderWidth,
              ),
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0, // 왼쪽과 오른쪽 여백
              vertical: 20.0, // 위와 아래 여백
            ),
          ),
          controller: controller,
        ),
      ],
    );
  }
}
