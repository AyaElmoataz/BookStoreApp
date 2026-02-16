class AppStrings {
  static const String appName = 'Book Store';

  // Titles/Headers
  static const String loginHeader = 'LOGIN';
  static const String registerHeader = 'REGISTER';

  // Fields
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';

  // Buttons & Links
  static const String loginButton = 'LOGIN';
  static const String registerButton = 'REGISTER';
  static const String dontHaveAccount = 'Don\'t have an account? ';
  static const String registerLink = 'Register';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String loginLink = 'Login';

  // Messages
  static const String registerSuccess = 'Account created successfully!';
  static const String errorInvalidEmail = 'Please enter a valid email address.';
  static const String errorEmailInUse =
      'An account already exists for that email.';
  static const String errorWrongPassword = 'Wrong password provided.';
  static const String errorUserNotFound = 'No user found for that email.';
  static const String errorWeakPassword = 'The password provided is too weak.';
  static const String errorGeneric = 'An error happened, please try again.';
  static const String errorInternetConnection =
      'Please check your internet connection.';
  static const String errorBooksLoadingFailure = 'Failed to load books';
  static const String errorServer = 'Server error occurred';
  static const String errorUnexpected = 'Unexpected error: ';
}
