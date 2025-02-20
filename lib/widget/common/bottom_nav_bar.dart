import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  static bool shouldShowInRoute(String route) {
    // 로그인과 회원가입 페이지에서는 bottom nav bar를 표시하지 않음
    return ![
      '/login',
      '/signup',
    ].contains(route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 라우트에서 bottom nav bar를 표시해야 하는지 확인
    if (!shouldShowInRoute(GoRouterState.of(context).uri.path)) {
      return const SizedBox.shrink();
    }

    final currentIndex = ref.watch(bottomNavIndexProvider);
    final routes = ['/main', '/calendar', '/my'];
    final bottomNavItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '홈',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: '통계',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '설정',
      ),
    ];

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        ref.read(bottomNavIndexProvider.notifier).state = index;
        context.go(routes[index]);
      },
      items: bottomNavItems,
    );
  }
}
