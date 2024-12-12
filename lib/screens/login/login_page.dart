import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobmoim/assets/style/fonts.dart';
import 'package:jobmoim/providers/main_provider.dart';
import 'package:jobmoim/widget/common/jm_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider 예시
    final value = ref.watch(currentTitleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              SvgPicture.asset(
                'lib/assets/images/pig.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyles.titleStyle,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
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
              onPressed: () {
                Navigator.pushNamed(context, '/main');
              },
              text: '다음',
            ),
          ],
        ),
      ),
    );
  }
}
