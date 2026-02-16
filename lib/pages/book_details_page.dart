import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/book_details_provider.dart';
import 'package:book_store_app/widgets/book_details_card.dart';
import 'package:book_store_app/widgets/error_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailsPage extends ConsumerStatefulWidget {
  final String isbn13;

  const BookDetailsPage({super.key, required this.isbn13});

  @override
  ConsumerState<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends ConsumerState<BookDetailsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(bookDetailsProvider(widget.isbn13));

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

        data: (book) {
          return BookDetailsCard(
            book: book,
            isFavorite: false, // temporary
            onAddToFavorites: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to favorites")),
              );
            },
          );
        },
      ),
    );
  }
}
