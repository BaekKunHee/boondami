import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final signupControllerProvider = Provider((ref) => SignupController());

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

final nicknameControllerProvider = StateProvider.autoDispose((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final isLoadingProvider = StateProvider.autoDispose((ref) => false);

class SignupController {
  Future<void> createUser({
    required String email,
    required String password,
    required String nickname,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    try {
      // 1. 회원가입
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        // 2. profiles 테이블에 사용자 정보 저장
        await Supabase.instance.client.from('profiles').insert({
          'id': authResponse.user!.id,
          'nickname': nickname,
          'created_at': DateTime.now().toIso8601String(),
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('회원가입이 완료되었습니다. 이메일 인증을 진행해주세요.'),
            ),
          );
          context.go('/login');
        }
      }
    } on PostgrestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 생성 실패: ${e.message}')),
        );
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        String errorMessage = '회원가입 실패';

        if (e.message.contains('already registered')) {
          errorMessage = '이미 등록된 이메일입니다';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('알 수 없는 오류가 발생했습니다: ${e.toString()}')),
        );
      }
    }
  }
}
