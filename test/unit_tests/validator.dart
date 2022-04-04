import 'package:flutter_test/flutter_test.dart';
import 'package:receipts/validator.dart';

void main() {
  group('Email Validation', () {
    test('Email validation of `null` should equal false', () {
      expect(Validator.isEmailValid(null), false);
    });
    test('Email validation of empty string should equal false', () {
      expect(Validator.isEmailValid(''), false);
    });
    test('Email validation of `lol.com` should equal false', () {
      expect(Validator.isEmailValid('lol.com'), false);
    });
    test('Email validation of `cryptography@crypto.gmail` should equal true',
        () {
      expect(Validator.isEmailValid('cryptography@crypto.gmail'), true);
    });
    test('Email validation of `cryptography@crypto.website` should equal true',
        () {
      expect(Validator.isEmailValid('cryptography@crypto.website'), true);
    });
  });

  group('Text Validation', () {
    test('Text validation of `null` should equal false', () {
      expect(Validator.isStringValid(null), false);
    });
    test('Text validation of empty string should equal false', () {
      expect(Validator.isStringValid(''), false);
    });
    test('Text validation of `Hello world` should equal true', () {
      expect(Validator.isStringValid('Hello world'), true);
    });
  });
}
