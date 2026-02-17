import 'package:book_store_app/constants/hive_constants.dart';
import 'package:book_store_app/models/book.dart';
import 'package:book_store_app/repositories/favorites_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final box = Hive.box<Book>(HiveConstants.booksBox);
  return FavoritesRepository(box);
});
