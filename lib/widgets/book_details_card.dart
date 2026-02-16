import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/models/book.dart';
import 'package:flutter/material.dart';

class BookDetailsCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onAddToFavorites;
  final bool isFavorite;

  const BookDetailsCard({
    super.key,
    required this.book,
    this.onAddToFavorites,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(book.image, height: 250, fit: BoxFit.cover),
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Subtitle
          if (book.subtitle.isNotEmpty)
            Text(
              book.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),

          const SizedBox(height: 16),

          // Price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: kPrimaryColor.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              book.price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Description
          if (book.description != null && book.description!.isNotEmpty)
            Text(
              book.description!,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),

          const SizedBox(height: 30),

          // Add to Favorites Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onAddToFavorites,
              style: ElevatedButton.styleFrom(
                backgroundColor: isFavorite ? Colors.red : kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              label: Text(
                isFavorite ? "Remove from Favorites" : "Add to Favorites",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
