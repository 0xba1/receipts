/// To validate `TextFormField`s
class Validator {
  /// Check if a String is a valid email.
  /// Returns true if it is valid.
  static bool isEmailValid(String? string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,7}$';
    final regExp = RegExp(pattern);

    if (regExp.hasMatch(string)) {
      return true;
    }
    return false;
  }

  /// Check if a String is null or empty.
  /// Returns true if not.
  static bool isStringValid(String? string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
      return false;
    }
    return true;
  }
}
