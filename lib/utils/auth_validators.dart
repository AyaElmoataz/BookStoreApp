import 'package:book_store_app/constants/app_strings.dart';

class AuthValidators {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validateEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  String? validateRequiredFields(String? value, [String fieldName = 'Field']) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  String? validateAuth(String email, String password) {
    String? emailValidationResult;
    String? passwordValidationResult;

    emailValidationResult = validateRequiredFields(email, AppStrings.emailHint);

    if (emailValidationResult != null) {
      return emailValidationResult;
    }

    passwordValidationResult = validateRequiredFields(
      password,
      AppStrings.passwordHint,
    );

    if (passwordValidationResult != null) {
      return passwordValidationResult;
    }

    if (!AuthValidators().validateEmail(email)) {
      return AppStrings.errorInvalidEmail;
    }

    return null;
  }
}
