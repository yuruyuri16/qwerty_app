// ignore_for_file: prefer_const_constructors

import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  const mockPassword = 'Averysecretpassword123!';
  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        const password = Password.pure();
        expect(password.value, '');
        expect(password.isPure, isTrue);
      });

      test('dirty creates correct instance', () {
        const password = Password.dirty(mockPassword);
        expect(password.value, mockPassword);
        expect(password.isPure, isFalse);
      });
    });

    group('validator', () {
      test('returns invalid error when password is empty', () {
        expect(
          Password.dirty().error,
          PasswordValidationError.invalid,
        );
      });

      test('returns invalid error when password is malformed', () {
        expect(
          Password.dirty('test').error,
          PasswordValidationError.invalid,
        );
      });

      test('is valid when password is valid', () {
        expect(Password.dirty(mockPassword).error, isNull);
      });
    });
  });
}
