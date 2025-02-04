import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/assets/style/colors.dart';
import 'package:jobmoim/providers/main_provider.dart';
import 'package:jobmoim/screens/main/main_page.dart';
import 'package:jobmoim/screens/task/task_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } catch (e) {
  //   print('Firebase initialization error: $e');
  // }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainController = ref.watch(mainProviderProvider.notifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boondami',
      theme: ThemeData(
        fontFamily: 'JGaegujaengyi',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomColors.background,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('분다미'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '검색',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: '나의 할일',
            ),
          ],
          currentIndex: mainController.currentIndex,
          onTap: (index) {
            mainController.onItemTapped(index);
          },
        ),
        body: const SafeArea(child: MainPage()),
      ),
      routes: {
        '/main': (context) => const MainPage(),
        '/task': (context) => const TaskPage(),
      },
    );
  }
}
