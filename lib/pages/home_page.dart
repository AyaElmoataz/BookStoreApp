import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/pages/book_details_page.dart';
import 'package:book_store_app/providers/app_theme_provider.dart';
import 'package:book_store_app/providers/book_provider.dart';
import 'package:book_store_app/providers/favorites_provider.dart';
import 'package:book_store_app/widgets/book_card.dart';
import 'package:book_store_app/widgets/error_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(booksProvider);
    final favorites = ref.watch(favoritesProvider);
    final themeAsync = ref.watch(appThemeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          themeAsync.when(
            data: (themeMode) {
              final isDark = themeMode == ThemeMode.dark;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                        const SizedBox(width: 6),
                        Text(
                          isDark ? "Dark Mode" : "Light Mode",
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                      child: Switch(
                        value: isDark,
                        onChanged: (value) {
                          ref
                              .read(appThemeProvider.notifier)
                              .setTheme(
                                value ? ThemeMode.dark : ThemeMode.light,
                              );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),

      body: booksAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),

        error: (err, stack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(err.toString())));
          });
          return Center(
            child: ErrorPlaceholder(text: AppStrings.errorBooksLoadingFailure),
          );
        },

        data: (booksResponse) {
          return ListView.builder(
            itemCount: booksResponse.books.length,
            itemBuilder: (context, index) {
              final book = booksResponse.books[index];

              final isFavorite = favorites.any(
                (fav) => fav.isbn13 == book.isbn13,
              );

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailsPage(isbn13: book.isbn13),
                    ),
                  );
                },
                child: BookCard(book: book, isFavorite: isFavorite),
              );
            },
          );
        },
      ),
    );
  }
}
