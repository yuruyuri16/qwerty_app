import 'package:formz/formz.dart';

/// Password Form Input Validation Error.
enum PasswordValidationError {
  /// Password is invalid (generic validation error)
  invalid;
}

/// {@template password}
/// Password form validation
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError> {
  /// {@macroo password}
  const Password.pure() : super.pure('');

  /// {@macro password}
  const Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
