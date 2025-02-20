import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jobmoim/screens/invite/invite_accept_page.dart';

import '../screens/create_group/create_group_page.dart';
import '../screens/group_detail/group_detail_page.dart';
import '../screens/login/login_page.dart';
import '../screens/main/main_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  const storage = FlutterSecureStorage();

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) async {
      // 토큰 확인
      final token = await storage.read(key: 'access_token');
      final isLoggedIn = token != null;

      final isGoingToLogin = state.uri.path == '/login';
      final isGoingToSignup = state.uri.path == '/signup';

      // 로그인하지 않은 상태에서 보호된 경로로 접근할 때
      if (!isLoggedIn &&
          !isGoingToLogin &&
          !isGoingToSignup &&
          state.uri.path != '/') {
        return '/login';
      }

      // 이미 로그인한 상태에서 로그인/회원가입 페이지로 가려고 할 때
      if (isLoggedIn && (isGoingToLogin || isGoingToSignup)) {
        return '/main';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),

      GoRoute(
        path: '/main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/create-group',
        builder: (context, state) => const CreateGroupPage(),
      ),
      GoRoute(
        path: '/group/:id',
        builder: (context, state) => GroupDetailPage(
          groupId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/invite/:id',
        builder: (context, state) => InviteAcceptPage(
          inviteId: state.pathParameters['id']!,
        ),
      ),
      // GoRoute(
      //   path: '/my',
      //   builder: (context, state) => const MyPage(),
      // ),
    ],
  );
});
