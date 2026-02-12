class AuthValidators {
  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool validateEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static String? validateRequiredFields(
    String? value, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }
}
