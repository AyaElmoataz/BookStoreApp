import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/login_loading_provider.dart';
import 'package:book_store_app/services/network_service.dart';
import 'package:book_store_app/utils/auth_error_helper.dart';
import 'package:book_store_app/utils/auth_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/home_page.dart';

// Simple Provider to access the controller
final loginControllerProvider = Provider((ref) => LoginController(ref));

class LoginController {
  final Ref ref;
  LoginController(this.ref);

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    String? authValidationResult = AuthValidators().validateAuth(
      email,
      password,
    );

    if (authValidationResult != null) {
      _showSnackBar(context, authValidationResult);
      return;
    }

    if (!await NetworkService().isConnected() && context.mounted) {
      _showSnackBar(context, AppStrings.errorInternetConnection);
      return;
    }

    // Start Loading
    ref.read(loginLoadingProvider.notifier).startLoading();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (context.mounted) _showSnackBar(context, AuthErrorHelper.message(e));
    } finally {
      ref.read(loginLoadingProvider.notifier).stopLoading();
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
