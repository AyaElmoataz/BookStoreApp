import 'package:book_store_app/models/books_response.dart';
import 'package:book_store_app/services/books_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksProvider = FutureProvider<BooksResponse>((ref) async {
  return BooksService(Dio()).getBooks();
});
