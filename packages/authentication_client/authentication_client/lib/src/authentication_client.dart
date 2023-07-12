/// Represents the authentication status of the application.
enum AuthenticationStatus {
  /// The status when the application is authenticated.
  authenticated,

  /// The status when the application is unauthenticated.
  unauthenticated;

  /// Whether the current status is authenticated.
  bool get isAuthenticated => this == authenticated;

  /// Whether the current status is unauthenticated.
  bool get isUnauthenticated => this == unauthenticated;
}

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
class AuthenticationException implements Exception {
  /// {@macro authentication_exception}
  const AuthenticationException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the sign in process if a failure occurs.
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure extends AuthenticationException {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure(super.error);
}

/// {@template register_failure}
/// Thrown during the register process if a failure occurs.
/// {@endtemplate}
class RegisterFailure extends AuthenticationException {
  /// {@macro register_failure}
  const RegisterFailure(super.error);
}

/// {@template log_out_failure}
/// Thrown during sign out process if a failure occurs.
/// {@endtemplate}
class LogOutFailure extends AuthenticationException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// A generic Authentication Client Interface.
abstract class AuthenticationClient {
  /// Stream of [AuthenticationStatus] which will emit the current
  /// authentication status.
  Stream<AuthenticationStatus> get authenticationStatus;

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs up with the provided [name], [lastName], [email] and [password].
  ///
  /// Throws a [RegisterFailure] if an exception occurs.
  Future<void> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  });

  /// Signs out the current user which will emit
  /// [AuthenticationStatus.unauthenticated] from the
  /// [authenticationStatus] stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut();
}
