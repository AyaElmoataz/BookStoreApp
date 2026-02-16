class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String price;
  final String image;
  final String url;

  Book({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      isbn13: json['isbn13'] as String? ?? '',
      price: json['price'] as String? ?? '',
      image: json['image'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}
