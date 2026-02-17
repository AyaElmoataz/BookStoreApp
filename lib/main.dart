import 'package:book_store_app/constants/hive_constants.dart';
import 'package:book_store_app/models/book.dart';
import 'package:book_store_app/pages/login_page.dart';
import 'package:book_store_app/providers/app_theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox<Book>(HiveConstants.booksBox);

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    return themeMode.when(
      data: (themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // Light theme
          theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ),
          ),

          // Dark theme
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),

          themeMode: themeMode,

          home: LoginPage(),
        );
      },
      loading: () => const SizedBox(),
      error: (e, _) => const SizedBox(),
    );
  }
}
