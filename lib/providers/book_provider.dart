import 'package:book_store_app/models/books_response.dart';
import 'package:book_store_app/providers/dio_provider.dart';
import 'package:book_store_app/services/books_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksProvider = FutureProvider<BooksResponse>((ref) {
  final dio = ref.watch(dioProvider);
  final service = BooksService(dio);

  return service.getBooks();
});
