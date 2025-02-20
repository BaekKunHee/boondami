import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // .env 파일 로드
  try {
    await dotenv.load();
  } catch (e) {
    debugPrint('Failed to load .env file: $e');
    // 여기서 기본값을 설정하거나 에러 처리를 할 수 있습니다
  }

  // Supabase 초기화
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Boondami',
            theme: ThemeData(
              fontFamily: 'JGaegujaengyi',
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: CustomColors.background,
              ),
            ),
          );
        },
      ),
    );
  }
}
