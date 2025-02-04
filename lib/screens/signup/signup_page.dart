import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/signup_provider.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperNotifierProvider);

    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(92),
        child: SizedBox(),
      ),
      body: SizedBox(),
    );
  }
}
