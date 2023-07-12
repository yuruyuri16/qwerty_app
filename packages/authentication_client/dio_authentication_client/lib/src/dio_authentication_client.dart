import 'package:authentication_client/authentication_client.dart';
import 'package:dio/dio.dart';
import 'package:dio_authentication_client/dio_authentication_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:token_storage/token_storage.dart';

/// {@template dio_authentication_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DioAuthenticationClient implements AuthenticationClient {
  /// {@macro dio_authentication_client}
  DioAuthenticationClient({
    required TokenStorage tokenStorage,
    Dio? httpClient,
  })  : _jwtInterceptor = JWTInterceptor(
          httpClient: httpClient,
          storage: tokenStorage,
          refreshToken: (token, httpClient) async {
            try {
              final refreshToken = token?.refreshToken;
              if (refreshToken == null) throw const RevokeTokenFailure();
              final _httpClient =
                  Dio(BaseOptions(baseUrl: httpClient.options.baseUrl));
              final response = await _httpClient.post<Map<String, dynamic>>(
                '/refresh',
                options: Options(
                  headers: {'Authorization': 'Bearer $refreshToken'},
                ),
              );
              final data = response.data;
              if (data == null) throw const RevokeTokenFailure();
              return OAuth2Token(
                accessToken: data['access_token'] as String,
                refreshToken: token?.refreshToken,
                expiresIn: token?.expiresIn,
                tokenType: token?.tokenType,
                scope: token?.scope,
              );
            } catch (_) {
              throw const RevokeTokenFailure();
            }
          },
        ),
        _httpClient = (httpClient ?? Dio())
          ..interceptors.add(PrettyDioLogger()) {
    _httpClient.interceptors.add(_jwtInterceptor);
  }

  final Dio _httpClient;
  final JWTInterceptor _jwtInterceptor;

  @override
  Stream<AuthenticationStatus> get authenticationStatus =>
      _jwtInterceptor.authenticationStatus;

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      final data = response.data;
      if (data == null) {
        throw const LogInWithEmailAndPasswordFailure('Response body is null');
      }
      final token = OAuth2Token.fromJson(data);
      await _jwtInterceptor.setToken(token);
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithEmailAndPasswordFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future<void> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await _httpClient.post<void>(
        '/register',
        data: {
          'name': name,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(RegisterFailure(error), stackTrace);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _httpClient.post<void>('/logout');
      await _jwtInterceptor.clearToken();
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}
