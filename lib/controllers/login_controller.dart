import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/loading_provider.dart';
import 'package:book_store_app/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/home_page.dart';

// Simple Provider to access the controller
final loginControllerProvider = Provider((ref) => LoginController(ref));

class LoginController {
  final Ref ref;
  LoginController(this.ref);

  String? email;
  String? password;

  void updateEmail(String value) => email = value;
  void updatePassword(String value) => password = value;

  Future<void> login(BuildContext context) async {
    String? emailValidationResult;
    String? passwordValidationResult;

    emailValidationResult = AuthValidators.validateRequiredFields(
      email,
      AppStrings.emailHint,
    );

    if (emailValidationResult != null) {
      _showSnackBar(context, emailValidationResult);
      return;
    }

    passwordValidationResult = AuthValidators.validateRequiredFields(
      password,
      AppStrings.passwordHint,
    );

    if (passwordValidationResult != null) {
      _showSnackBar(context, passwordValidationResult);
      return;
    }

    if (!AuthValidators().validateEmail(email!)) {
      _showSnackBar(context, AppStrings.errorInvalidEmail);
      return;
    }

    // Start Loading
    ref.read(loadingProvider.notifier).startLoading();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!.trim(),
        password: password!,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = AppStrings.errorGeneric;
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        message = AppStrings.errorUserNotFound;
      } else if (e.code == 'wrong-password') {
        message = AppStrings.errorWrongPassword;
      }
      if (context.mounted) _showSnackBar(context, message);
    } catch (e) {
      if (context.mounted) _showSnackBar(context, AppStrings.errorGeneric);
    } finally {
      ref.read(loadingProvider.notifier).stopLoading();
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
