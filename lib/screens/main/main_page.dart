import 'package:flutter/material.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/screens/main/widget/main_circle.dart';
import 'package:jobmoim/widget/common/jm_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('행복한저금통 만들기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            children: [
              const Text('현재 행복도'),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) => const MainCircle(),
                ),
              ),
              JmButton(
                color: CustomColors.primary80,
                onPressed: () {
                  Navigator.pushNamed(context, '/happy');
                },
                text: '다음',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
