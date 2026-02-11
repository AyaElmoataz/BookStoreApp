import 'package:book_store_app/constants.dart';
import 'package:book_store_app/pages/home_page.dart';
import 'package:book_store_app/pages/register_page.dart';
import 'package:book_store_app/providers/loading_provider.dart';
import 'package:book_store_app/widgets/custom_button.dart';
import 'package:book_store_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const CircularProgressIndicator(color: kPrimaryColor),
      child: Scaffold(
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
              CustomTextField(
                hintText: 'Email',
                isPassword: false,
                onChanged: (data) {
                  email = data;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                hintText: 'Password',
                isPassword: true,
                onChanged: (data) {
                  password = data;
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                onTap: () async {
                  await loginUser(context, ref);
                },
                text: 'LOGIN',
              ),
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
      ),
    );
  }

  Future<void> loginUser(BuildContext context, WidgetRef ref) async {
    // Set loader to true
    ref.read(loadingProvider.notifier).startLoading();

    try {
      if (email == null || password == null) {
        showSnackBar(context, 'Email/Password is empty.');
        // Set loader back to false
        ref.read(loadingProvider.notifier).stopLoading();
        return;
      }

      if (!isValidEmail()) {
        showSnackBar(context, 'Please enter a valid email address.');
        // Set loader back to false
        ref.read(loadingProvider.notifier).stopLoading();
        return;
      }

      var auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      // Navigate to Home Page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      }
    } catch (e) {
      showSnackBar(context, 'An error happened, please try again.');
      print(e);
    } finally {
      // Set loader back to false
      ref.read(loadingProvider.notifier).stopLoading();
    }
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!);
  }
}
