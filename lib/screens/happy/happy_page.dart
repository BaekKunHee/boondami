import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/widget/common/jm_button.dart';

class HappyPage extends StatelessWidget {
  const HappyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          children: [
            JmButton(
              onPressed: () {},
              text: '행복장 가기',
              color: CustomColors.primary80,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('행복 꿀꿀이'),
            SvgPicture.asset(
              'lib/assets/images/pig.svg',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
