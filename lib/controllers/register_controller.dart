import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/loading_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/home_page.dart';

final registerControllerProvider = Provider((ref) => RegisterController(ref));

class RegisterController {
  final Ref ref;
  RegisterController(this.ref);

  String? email;
  String? password;

  void updateEmail(String value) => email = value;
  void updatePassword(String value) => password = value;

  Future<void> register(BuildContext context) async {
    if (email == null ||
        password == null ||
        email!.isEmpty ||
        password!.isEmpty) {
      _showSnackBar(context, AppStrings.errorEmptyFields);
      return;
    }

    if (!_isValidEmail()) {
      _showSnackBar(context, AppStrings.errorInvalidEmail);
      return;
    }

    // Start Loading
    ref.read(loadingProvider.notifier).startLoading();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!,
      );

      if (context.mounted) {
        _showSnackBar(context, AppStrings.registerSuccess);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = AppStrings.errorGeneric;
      if (e.code == 'email-already-in-use') {
        message = AppStrings.errorEmailInUse;
      } else if (e.code == 'weak-password') {
        message = AppStrings.errorWeakPassword;
      }
      if (context.mounted) _showSnackBar(context, message);
    } catch (e) {
      if (context.mounted) _showSnackBar(context, AppStrings.errorGeneric);
    } finally {
      ref.read(loadingProvider.notifier).stopLoading();
    }
  }

  bool _isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!);
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
