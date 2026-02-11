import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText, this.isPassword = false, this.onChanged});

  final String? hintText;
  final bool isPassword;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xff009cda)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff004380)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff004380)),
        ),
      ),
    );
  }
}
