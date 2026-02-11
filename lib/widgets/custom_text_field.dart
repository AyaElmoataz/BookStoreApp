import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hintText});

  String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
