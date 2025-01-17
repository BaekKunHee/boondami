import 'package:flutter/material.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/assets/style/fonts.dart';
import 'package:jobmoim/widget/common/jm_button.dart';

class SignupInput extends StatelessWidget {
  const SignupInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '닉네임',
            style: TextStyles.baseStyle,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              ),
              hintText: '닉네임을 입력해주세요',
            ),
          ),
          const Spacer(), // Add Spacer to push button to bottom
          JmButton(
            color: CustomColors.primary80,
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            text: '다음',
          ),
        ],
      ),
    );
  }
}
