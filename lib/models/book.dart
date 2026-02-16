import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  // Common fields

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  @HiveField(2)
  final String isbn13;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String url;

  // Details-only fields
  @HiveField(6)
  final String? authors;
  @HiveField(7)
  final String? publisher;
  @HiveField(8)
  final String? isbn10;
  @HiveField(9)
  final String? pages;
  @HiveField(10)
  final String? year;
  @HiveField(11)
  final String? rating;
  @HiveField(12)
  final String? description;
  @HiveField(13)
  final Map<String, String>? pdf;

  Book({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
    this.authors,
    this.publisher,
    this.isbn10,
    this.pages,
    this.year,
    this.rating,
    this.description,
    this.pdf,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      isbn13: json['isbn13'] as String? ?? '',
      price: json['price'] as String? ?? '',
      image: json['image'] as String? ?? '',
      url: json['url'] as String? ?? '',
      authors: json['authors'] as String?,
      publisher: json['publisher'] as String?,
      isbn10: json['isbn10'] as String?,
      pages: json['pages'] as String?,
      year: json['year'] as String?,
      rating: json['rating'] as String?,
      description: json['desc'] as String?,
      pdf: (json['pdf'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, value as String),
      ),
    );
  }
}
