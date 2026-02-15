import 'package:book_store_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.hintText,
    this.isPassword = false,
    this.controller,
    super.key,
  });

  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: kSecondaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}
