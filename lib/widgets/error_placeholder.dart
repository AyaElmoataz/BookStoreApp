import 'package:book_store_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
