import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final loginControllerProvider = Provider((ref) => LoginController(ref));

final emailControllerProvider = StateProvider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final passwordControllerProvider = StateProvider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

class LoginController {
  final Ref ref;
  final storage = const FlutterSecureStorage();

  LoginController(this.ref);

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
    VoidCallback? onSuccess,
  }) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null && response.session != null) {
        // 토큰 저장
        await storage.write(
          key: 'access_token',
          value: response.session!.accessToken,
        );
        await storage.write(
          key: 'refresh_token',
          value: response.session!.refreshToken,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('로그인 성공!')),
          );

          onSuccess?.call();
          context.go('/main');
        }
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        String errorMessage = '로그인 실패';

        // 에러 메시지를 사용자 친화적으로 변환
        if (e.message == 'Invalid login credentials') {
          errorMessage = '이메일 또는 비밀번호가 올바르지 않습니다';
        } else if (e.message.contains('Email not confirmed')) {
          errorMessage = '이메일 인증이 필요합니다';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('알 수 없는 오류가 발생했습니다')),
        );
      }
    }
  }

  // 토큰 조회 메서드 추가
  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  // 토큰 삭제 메서드 추가 (로그아웃 시 사용)
  Future<void> deleteTokens() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }
}
