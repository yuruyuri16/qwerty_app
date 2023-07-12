import 'dart:async';

import 'package:authentication_client/authentication_client.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/subjects.dart';
import 'package:token_storage/token_storage.dart';

/// {@template revoke_token_failure}
/// Thrown during the refresh token process if a failure occurs and should
/// result in a force-logout.
class RevokeTokenFailure implements Exception {
  /// {@macro revoke_token_failure}
  const RevokeTokenFailure();
}

///
typedef TokenHeaderBuilder = Map<String, String> Function(OAuth2Token token);

///
typedef RefreshToken = Future<OAuth2Token> Function(
  OAuth2Token? token,
  Dio httpClient,
);

/// {@template jwt_interceptor}
/// {@endtemplate}
class JWTInterceptor implements Interceptor {
  /// {@macro jwt_interceptor}
  JWTInterceptor({
    required TokenStorage storage,
    required RefreshToken refreshToken,
    Dio? httpClient,
  })  : _storage = storage,
        _httpClient = httpClient ?? Dio(),
        _refreshToken = refreshToken,
        _authenticationSubject = BehaviorSubject() {
    unawaited(_initialize());
  }

  final BehaviorSubject<AuthenticationStatus> _authenticationSubject;

  final Dio _httpClient;
  final TokenStorage _storage;
  final RefreshToken _refreshToken;
  late OAuth2Token? _token;

  ///
  Stream<AuthenticationStatus> get authenticationStatus =>
      _authenticationSubject.asBroadcastStream();

  Future<void> _initialize() async {
    final token = await _storage.read();
    if (token == null) {
      _token = null;
      _authenticationSubject.add(AuthenticationStatus.unauthenticated);
    } else {
      _token = token;
      _authenticationSubject.add(AuthenticationStatus.authenticated);
    }
  }

  ///
  Future<void> setToken(OAuth2Token token) async {
    await _storage.write(token);
    _token = token;
    _authenticationSubject.add(AuthenticationStatus.authenticated);
  }

  ///
  Future<void> clearToken() async {
    await _storage.delete();
    _token = null;
    _authenticationSubject.add(AuthenticationStatus.unauthenticated);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var header = <String, String>{};
    final accessToken = _token?.accessToken;
    final refreshToken = _token?.refreshToken;
    final tokenType = _token?.tokenType;
    if (options.path == '/refresh' &&
        refreshToken != null &&
        tokenType != null) {
      header = {'Authorization': '$tokenType $refreshToken'};
    } else if (accessToken != null && tokenType != null) {
      header = {'Authorization': '$tokenType $accessToken'};
    }
    print('onRequest: $header');
    options.headers.addAll(header);
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (_token == null || !_shouldRefresh(response)) {
      return handler.next(response);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.reject(error);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response == null ||
        _token == null ||
        err.error is RevokeTokenFailure ||
        !_shouldRefresh(response)) {
      return handler.next(err);
    }
    try {
      final refreshResponse = await _tryRefresh(response);
      handler.resolve(refreshResponse);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

  Future<Response<dynamic>> _tryRefresh(Response<dynamic> response) async {
    late final OAuth2Token refreshedToken;
    try {
      refreshedToken = await _refreshToken(_token, _httpClient);
    } on RevokeTokenFailure catch (error) {
      await clearToken();
      throw DioException(
        requestOptions: response.requestOptions,
        error: error,
        response: response,
      );
    }

    await setToken(refreshedToken);
    _httpClient.options.baseUrl = response.requestOptions.baseUrl;
    var header = <String, String>{};
    final accessToken = _token?.accessToken;
    if (accessToken != null) header = {'Authorization': accessToken};
    return _httpClient.request<dynamic>(
      response.requestOptions.path,
      cancelToken: response.requestOptions.cancelToken,
      data: response.requestOptions.data,
      onReceiveProgress: response.requestOptions.onReceiveProgress,
      onSendProgress: response.requestOptions.onSendProgress,
      queryParameters: response.requestOptions.queryParameters,
      options: Options(
        method: response.requestOptions.method,
        sendTimeout: response.requestOptions.sendTimeout,
        receiveTimeout: response.requestOptions.receiveTimeout,
        extra: response.requestOptions.extra,
        headers: response.requestOptions.headers..addAll(header),
        responseType: response.requestOptions.responseType,
        contentType: response.requestOptions.contentType,
        validateStatus: response.requestOptions.validateStatus,
        receiveDataWhenStatusError:
            response.requestOptions.receiveDataWhenStatusError,
        followRedirects: response.requestOptions.followRedirects,
        maxRedirects: response.requestOptions.maxRedirects,
        requestEncoder: response.requestOptions.requestEncoder,
        responseDecoder: response.requestOptions.responseDecoder,
        listFormat: response.requestOptions.listFormat,
      ),
    );
  }

  static bool _shouldRefresh(Response<dynamic>? response) {
    return response?.statusCode == 401;
  }
}
