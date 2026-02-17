import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:book_store_app/models/book.dart';
import 'package:book_store_app/providers/favorites_repository_provider.dart';
import 'package:book_store_app/repositories/favorites_repository.dart';

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<Book>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<List<Book>> {
  late final FavoritesRepository _repo;

  @override
  List<Book> build() {
    _repo = ref.read(favoritesRepositoryProvider);
    return _repo.getFavorites();
  }

  Future<void> add(Book book) async {
    await _repo.addToFavorites(book);
    state = [...state, book];
  }

  Future<void> remove(Book book) async {
    await _repo.removeFromFavorites(book);
    state = state.where((b) => b.isbn13 != book.isbn13).toList();
  }
}
