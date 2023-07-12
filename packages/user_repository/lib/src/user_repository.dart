import 'package:authentication_client/authentication_client.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:user_repository/user_repository.dart';

/// {@template user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required AuthenticationClient authenticationClient,
    required QwertyApiClient apiClient,
  })  : _authenticationClient = authenticationClient,
        _apiClient = apiClient;

  final AuthenticationClient _authenticationClient;
  final QwertyApiClient _apiClient;

  /// Stream of [User] which will emit the current user when
  /// authentication status changes.
  Stream<User> get user =>
      _authenticationClient.authenticationStatus.asyncMap((status) async {
        if (status.isUnauthenticated) return User.anonymous;
        try {
          final authenticationUser = await _apiClient.getUser();
          return User.fromAuthenticatedUser(
            authenticationUser: authenticationUser,
          );
        } catch (_) {
          return User.anonymous;
        }
      });

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on LogInWithEmailAndPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        LogInWithEmailAndPasswordFailure(error),
        stackTrace,
      );
    }
  }

  /// Signs up with the provided [name], [lastName], [email] and [password].
  ///
  /// Throws a [RegisterFailure] if an exception occurs.
  Future<void> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationClient.register(
        name: name,
        lastName: lastName,
        email: email,
        password: password,
      );
    } on RegisterFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(RegisterFailure(error), stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.anonymous] from the [user] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }
}
