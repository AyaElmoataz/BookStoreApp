import 'package:book_store_app/constants/app_strings.dart';
import 'package:book_store_app/providers/register_loading_provider.dart';
import 'package:book_store_app/services/network_service.dart';
import 'package:book_store_app/utils/auth_error_helper.dart';
import 'package:book_store_app/utils/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/home_page.dart';

final registerControllerProvider = Provider((ref) => RegisterController(ref));

class RegisterController {
  final Ref ref;
  RegisterController(this.ref);
  final networkService = NetworkService();

  Future<void> register(
    BuildContext context,
    String email,
    String password,
  ) async {
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

    if (!await networkService.isConnected() && context.mounted) {
      _showSnackBar(context, AppStrings.errorInternetConnection);
      return;
    }

    // Start Loading
    ref.read(registerLoadingProvider.notifier).startLoading();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      if (context.mounted) {
        _showSnackBar(context, AppStrings.registerSuccess);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (context.mounted) _showSnackBar(context, AuthErrorHelper.message(e));
    } finally {
      ref.read(registerLoadingProvider.notifier).stopLoading();
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
