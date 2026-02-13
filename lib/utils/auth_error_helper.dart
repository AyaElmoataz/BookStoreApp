import 'package:book_store_app/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHelper {
  static String message(
    Object error, [
    String fallback = AppStrings.errorGeneric,
  ]) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return AppStrings.errorUserNotFound;
        case 'invalid-credential':
          return AppStrings.errorUserNotFound;
        case 'wrong-password':
          return AppStrings.errorWrongPassword;
        case 'email-already-in-use':
          return AppStrings.errorEmailInUse;
        case 'weak-password':
          return AppStrings.errorWeakPassword;
        default:
          return fallback;
      }
    }
    return fallback;
  }
}
