import 'package:book_store_app/models/book.dart';

class BooksResponse {
  final String total;
  final String page;
  final List<Book> books;

  BooksResponse({required this.total, required this.page, required this.books});

  factory BooksResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> items = json['books'] ?? [];

    return BooksResponse(
      total: json['total'] as String? ?? '0',
      page: json['page'] as String? ?? '1',
      books: items
          .map((item) => Book.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
