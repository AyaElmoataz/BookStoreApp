import 'package:book_store_app/constants/app_colors.dart';
import 'package:book_store_app/models/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final bool isFavorite;

  const BookCard({super.key, required this.book, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                book.image,
                height: 120,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    book.subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade200),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    book.price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Visibility(
                    visible: isFavorite,
                    child: Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
