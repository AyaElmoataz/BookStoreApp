import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/book_provider.dart';
import 'package:book_store_app/widgets/book_card.dart';
import 'package:book_store_app/widgets/no_data_placeholder.dart';
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
            child: NoDataPlaceholder(text: AppStrings.errorBooksLoadingFailure),
          );
        },

        data: (booksResponse) {
          return ListView.builder(
            itemCount: booksResponse.books.length,
            itemBuilder: (context, index) {
              return BookCard(book: booksResponse.books[index]);
            },
          );
        },
      ),
    );
  }
}
