import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/assets/style/fonts.dart';
import 'package:jobmoim/widget/common/bm_button.dart';
import 'package:jobmoim/widget/common/bm_image.dart';
import 'package:jobmoim/widget/common/bm_input.dart';

class SignupOne extends ConsumerWidget {
  const SignupOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const BMImage(
                imageUrl: 'lib/assets/images/pig.svg',
                width: 24,
                height: 24,
                imageType: ImageType.svg,
              ),
              const SizedBox(width: 8),
              Text(
                '내가 너를 어떻게 부르면 될까?',
                style: TextStyles.titleStyle,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BMInput(
                  label: '닉네임',
                  hintText: '최대 6글자',
                ),
                BMButton(
                  color: CustomColors.primary80,
                  onPressed: () =>
                      // ref.read(stepperNotifierProvider.notifier).nextStep(),
                      Navigator.pushNamed(context, '/shelf'),
                  text: '다음',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
