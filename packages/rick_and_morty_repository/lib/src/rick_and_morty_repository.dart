import 'package:qwerty_api_client/qwerty_api_client.dart';

/// {@template rick_and_morty_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class RickAndMortyRepository {
  /// {@macro rick_and_morty_repository}
  const RickAndMortyRepository({
    required QwertyApiClient apiClient,
  }) : _apiClient = apiClient;

  final QwertyApiClient _apiClient;

  ///
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      return await _apiClient.getCharacters(page: page);
    } on GetCharactersFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetCharactersFailure(error), stackTrace);
    }
  }
}
