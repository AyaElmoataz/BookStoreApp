import 'package:book_store_app/constants/api_constants.dart';
import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/models/books_response.dart';
import 'package:book_store_app/services/network_service.dart';
import 'package:dio/dio.dart';

class BooksService {
  final Dio dio;

  BooksService(this.dio);

  Future<BooksResponse> getBooks() async {
    try {
      if (!await NetworkService().isConnected()) {
        throw Exception(AppStrings.errorInternetConnection);
      }

      final response = await dio.get(ApiConstants.getBooksApiUrl);

      return BooksResponse.fromJson(response.data);
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
