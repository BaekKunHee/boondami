import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://lokevrfplvmsiozotluw.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxva2V2cmZwbHZtc2lvem90bHV3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2MzQ4NzksImV4cCI6MjA1NDIxMDg3OX0.y7jaML5dY1GQ8s2bmFVOJXxq_d1eHeoDXpbw7nxuZK4');
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
