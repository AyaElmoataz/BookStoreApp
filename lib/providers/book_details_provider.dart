import 'package:book_store_app/models/book.dart';
import 'package:book_store_app/providers/dio_provider.dart';
import 'package:book_store_app/services/books_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookDetailsProvider = FutureProvider.family<Book, String>((ref, isbn13) {
  final dio = ref.watch(dioProvider);
  final service = BooksService(dio);

  return service.getBookDetails(isbn13);
});
