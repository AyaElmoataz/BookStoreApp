import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/models/books_response.dart';
import 'package:book_store_app/services/network_service.dart';
import 'package:dio/dio.dart';
import 'package:book_store_app/models/book.dart';

class BooksService {
  final Dio dio;

  BooksService(this.dio);

  Future<BooksResponse> getBooks() async {
    try {
      if (!await NetworkService().isConnected()) {
        throw Exception(AppStrings.errorInternetConnection);
      }

      final response = await dio.get(AppStrings.getBooksApiUrl);

      final data = response.data;

      final List<dynamic> items = data['books'] ?? [];

      List<Book> books = items.map((item) {
        return Book(
          title: item['title'] ?? '',
          subtitle: item['subtitle'] ?? '',
          isbn13: item['isbn13'] ?? '',
          price: item['price'] ?? '',
          image: item['image'] ?? '',
          url: item['url'] ?? '',
        );
      }).toList();

      return BooksResponse(
        total: data['total'] ?? '0',
        page: data['page'] ?? '1',
        books: books,
      );
    }
    /// 🔹 Dio Errors (timeout, 500, etc.)
    on DioException catch (e) {
      throw Exception(e.message ?? AppStrings.errorServer);
    }
    /// 🔹 Any Other Error
    catch (e) {
      throw Exception(AppStrings.errorUnexpected + e.toString());
    }
  }
}
