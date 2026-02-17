import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/book_details_provider.dart';
import 'package:book_store_app/providers/favorites_provider.dart';
import 'package:book_store_app/widgets/book_details_card.dart';
import 'package:book_store_app/widgets/error_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailsPage extends ConsumerWidget {
  final String isbn13;

  const BookDetailsPage({super.key, required this.isbn13});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailsProvider(isbn13));
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          AppStrings.appName,
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: bookAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),

        error: (err, stack) {
          return Center(
            child: ErrorPlaceholder(text: AppStrings.errorBooksLoadingFailure),
          );
        },

        data: (book) {
          final isFavorite = favorites.any((fav) => fav.isbn13 == book.isbn13);

          return BookDetailsCard(
            book: book,
            isFavorite: isFavorite,
            onAddToFavorites: () async {
              if (isFavorite) {
                await ref.read(favoritesProvider.notifier).remove(book);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Removed from favorites")),
                  );
                }
              } else {
                await ref.read(favoritesProvider.notifier).add(book);

                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Added to favorites")));
                }
              }
            },
          );
        },
      ),
    );
  }
}
