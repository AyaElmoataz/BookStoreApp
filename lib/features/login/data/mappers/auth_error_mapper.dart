import 'package:book_store_app/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../exceptions/auth_exception.dart';

class AuthErrorMapper {
  static AuthException map(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException(AppStrings.errorUserNotFound);
      case 'invalid-credential':
        return AuthException(AppStrings.errorUserNotFound);
      case 'wrong-password':
        return AuthException(AppStrings.errorWrongPassword);
      case 'email-already-in-use':
        return AuthException(AppStrings.errorEmailInUse);
      case 'weak-password':
        return AuthException(AppStrings.errorWeakPassword);
      case 'invalid-email':
        return AuthException(AppStrings.errorInvalidEmail);
      default:
        return AuthException(AppStrings.errorGeneric);
    }
  }
}
