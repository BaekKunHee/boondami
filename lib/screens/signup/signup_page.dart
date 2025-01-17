import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jobmoim/assets/style/fonts.dart';
import 'package:jobmoim/providers/signup_provider.dart';
import 'package:jobmoim/screens/signup/widgets/signup_one.dart';
import 'package:jobmoim/screens/signup/widgets/signup_two.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperNotifierProvider);

    return PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(92),
            child: currentStep > 0
                ? SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/images/left_arrow.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '뒤로가기',
                            style: TextStyles.titleStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 102,
                  ),
          ),
          body: _getStepWidget(currentStep),
        ));
  }

  Widget _getStepWidget(int step) {
    switch (step) {
      case 0:
        return const SignupOne();
      case 1:
        return const SignupTwo();
      default:
        return const SignupOne();
    }
  }
}
