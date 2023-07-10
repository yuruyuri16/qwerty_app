// ignore_for_file: prefer_const_constructors

import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const mockEmail = 'test@gmail.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const email = Email.pure();
        expect(email.value, '');
        expect(email.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const email = Email.dirty(mockEmail);
        expect(email.value, mockEmail);
        expect(email.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns invalid error when email is empty', () {
        expect(Email.dirty().error, EmailValidationError.invalid);
      });

      test('returns invalid error when email is malformed', () {
        expect(Email.dirty('test').error, EmailValidationError.invalid);
      });

      test('is valid when email is valid', () {
        expect(Email.dirty(mockEmail).error, isNull);
      });
    });
  });
}
