import 'package:qwerty_api_client/qwerty_api_client.dart';

/// {@template qwerty_api_exception}
/// {@endtemplate}
abstract class QwertyApiException implements Exception {
  /// {@macro qwerty_api_exception}
  const QwertyApiException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template get_user_failure}
/// {@endtemplate}
class GetUserFailure extends QwertyApiException {
  /// {@macro get_user_failure}
  const GetUserFailure(super.error);
}

/// {@template get_characters_failure}
/// {@endtemplate}
class GetCharactersFailure extends QwertyApiException {
  /// {@macro get_characters_failure}
  const GetCharactersFailure(super.error);
}

/// A Very Good Project created by Very Good CLI.
abstract class QwertyApiClient {
  ///
  Future<AuthenticationUser> getUser();

  ///
  Future<List<Character>> getCharacters({int page = 1});
}
