import 'package:book_store_app/models/book.dart';

class BooksResponse {
  final String total;
  final String page;
  final List<Book> books;

  BooksResponse({required this.total, required this.page, required this.books});
}
