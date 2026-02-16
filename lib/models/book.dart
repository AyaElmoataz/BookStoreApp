class Book {
  // Common fields
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;
  final String url;

  // Details-only fields
  final String? authors;
  final String? publisher;
  final String? isbn10;
  final String? pages;
  final String? year;
  final String? rating;
  final String? description;
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
