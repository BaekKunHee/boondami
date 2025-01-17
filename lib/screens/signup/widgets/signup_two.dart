import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/providers/signup_provider.dart';
import 'package:jobmoim/widget/common/jm_button.dart';
import 'package:jobmoim/widget/common/jm_input.dart';

class SignupTwo extends ConsumerWidget {
  const SignupTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: JMInput(
            label: '닉네임',
            hintText: '최대 6글자',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: JmButton(
            color: CustomColors.primary80,
            onPressed: () =>
                ref.read(stepperNotifierProvider.notifier).nextStep(),
            text: '다음',
          ),
        )
      ],
    );
  }
}
