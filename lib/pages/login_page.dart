import 'package:book_store_app/constants.dart';
import 'package:book_store_app/pages/register_page.dart';
import 'package:book_store_app/widgets/custom_button.dart';
import 'package:book_store_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Spacer(flex: 4),
            Image.asset('assets/images/icon.png', width: 100),
            Spacer(flex: 1),
            Text(
              'Book Store',
              style: TextStyle(fontSize: 32, color: kPrimaryColor),
            ),
            Spacer(flex: 2),
            Row(
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24, color: kPrimaryColor),
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomTextField(hintText: 'Email'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'Password'),
            SizedBox(height: 10),
            CustomButton(text: 'LOGIN'),
            Spacer(flex: 1),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account? ',
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: kSecondaryColor),
                  ),
                ),
              ],
            ),

            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
