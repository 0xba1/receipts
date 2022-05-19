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
    
    return regExp.hasMatch(string);

  }

  /// Check if a String is null or empty.
  /// Returns true if not.
  static bool isStringValid(String? string) {
    // Null or empty string is invalid
    return !(string == null || string.isEmpty);
  }
}
