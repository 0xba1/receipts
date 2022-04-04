import 'package:flutter/material.dart';

/// All keys used in project
class Keys {
  /// Login Form key
  static GlobalKey<FormState> logInFormKey =
      GlobalKey<FormState>(debugLabel: 'login');

  /// Signup Form key
  static GlobalKey<FormState> signUpFormKey =
      GlobalKey<FormState>(debugLabel: 'signup');

  /// New receipt Form key
  static GlobalKey<FormState> receiptFormKey =
      GlobalKey<FormState>(debugLabel: 'new_receipt');
}
