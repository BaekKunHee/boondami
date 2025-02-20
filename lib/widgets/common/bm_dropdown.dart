import 'package:flutter/material.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/widgets/common/bm_image.dart';
import 'package:jobmoim/widgets/common/bm_text.dart';

class BMPopupMenuButton<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;
  final String Function(T) getLabel;

  const BMPopupMenuButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.getLabel,
    this.hint = '선택해주세요',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 34,
      decoration: BoxDecoration(
        color: CustomColors.green50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: PopupMenuButton<T>(
        initialValue: value,
        onSelected: onChanged,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 100,
        ),
        itemBuilder: (context) => items.map((item) {
          final bool isSelected = value == item;
          return PopupMenuItem<T>(
            value: item,
            child: Row(
              children: [
                Expanded(
                  child: BMText(
                    getLabel(item),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: CustomColors.green50,
                    size: 20,
                  ),
              ],
            ),
          );
        }).toList(),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                child: BMText(
                  value != null ? getLabel(value as T) : hint,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const BMImage(
                imageUrl: 'lib/assets/images/arrow_down.svg',
                imageType: ImageType.svg,
                width: 26,
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
