import 'package:book_store_app/core/injections.dart';
import 'package:book_store_app/features/login/presentation/pages/login_page.dart';
import 'package:book_store_app/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // Inject all dependencies
  await initInjections();

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(appThemeProvider);

    return themeAsync.when(
      data: (themeAsync) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // Light theme
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            brightness: Brightness.light,
          ),

          // Dark theme
          darkTheme: ThemeData(brightness: Brightness.dark),

          themeMode: themeAsync,

          home: LoginPage(),
        );
      },
      loading: () => const SizedBox(),
      error: (e, _) => const SizedBox(),
    );
  }
}
