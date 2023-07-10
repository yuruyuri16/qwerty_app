import 'package:dio/dio.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';

/// {@template dio_qwerty_api_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DioQwertyApiClient implements QwertyApiClient {
  /// {@macro dio_qwerty_api_client}
  DioQwertyApiClient({
    Dio? httpClient,
  }) : _httpClient = httpClient ?? Dio();

  final Dio _httpClient;

  @override
  Future<AuthenticationUser> getUser() async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>('/me');
      final data = response.data;
      if (data == null) throw const GetUserFailure('Response body is null');
      return AuthenticationUser.fromJson(data);
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(GetUserFailure(error), stackTrace);
    }
  }

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _httpClient.get<List<dynamic>>(
        '/characters',
        queryParameters: {'page': page},
      );
      final data = response.data;
      if (data == null) {
        throw const GetCharactersFailure('Response body is null');
      }
      final characters = data
          .map((json) => Character.fromJson(json as Map<String, dynamic>))
          .toList();
      return characters;
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(GetCharactersFailure(error), stackTrace);
    }
  }
}
