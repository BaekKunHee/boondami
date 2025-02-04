import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_provider.g.dart';

@riverpod
class MainProvider extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 0; // 초기 선택된 탭 인덱스
  }

  int currentIndex = 0;

  // 탭 변경 메서드
  void onItemTapped(int index) {
    currentIndex = index;
  }
}
