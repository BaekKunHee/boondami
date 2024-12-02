import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/main_provider.dart';
import 'package:jobmoim/widget/common/jm_button.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider 예시
    final value = ref.watch(mainProviderProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('행복한저금통 만들기'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '닉네임',
              style: TextStyle(fontSize: 18),
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
