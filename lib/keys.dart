import 'package:flutter/material.dart';

/// All keys used in project
class Keys {
  /// Login Form key
  static GlobalKey logInFormKey = GlobalKey<FormState>(debugLabel: 'login');

  /// Signup Form key
  static GlobalKey signUpFormKey = GlobalKey<FormState>(debugLabel: 'signup');

  /// New receipt Form key
  static GlobalKey receiptFormKey =
      GlobalKey<FormState>(debugLabel: 'new_receipt');
}
