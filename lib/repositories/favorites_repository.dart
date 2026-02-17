import 'package:book_store_app/models/book.dart';
import 'package:hive/hive.dart';

class FavoritesRepository {
  final Box<Book> box;

  FavoritesRepository(this.box);

  Future<void> addToFavorites(Book book) async {
    await box.add(book);
  }

  Future<void> removeFromFavorites(Book book) async {
    await box.delete(book);
  }

  List<Book> getFavorites() {
    return box.values.toList();
  }
}
