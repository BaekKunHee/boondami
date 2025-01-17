import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_provider.g.dart';

@riverpod
String currentTitle(Ref ref) {
  return '내가 너를 어떻게 부르면 될까?';
}

@riverpod
class StepperNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    // 초기 단계 설정 (0단계부터 시작)
    return 0;
  }

  // 다음 단계로 이동
  void nextStep() {
    if (state < 3) {
      // 총 4단계일 경우
      state = state + 1;
    }
  }

  // 이전 단계로 이동
  void previousStep() {
    if (state > 0) {
      state = state - 1;
    }
  }

  // 특정 단계로 이동
  void goToStep(int step) {
    if (step >= 0 && step <= 3) {
      // 총 4단계일 경우
      state = step;
    }
  }
}
