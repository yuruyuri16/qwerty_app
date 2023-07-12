import 'package:equatable/equatable.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';

/// {@template user}
/// User model which represents the current user.
/// {@endtemplate}
class User extends AuthenticationUser {
  /// {@macro user}
  const User({
    required super.name,
    required super.lastName,
    required super.email,
  });

  /// Converts [AuthenticationUser] to [User].
  factory User.fromAuthenticatedUser({
    required AuthenticationUser authenticationUser,
  }) =>
      User(
        name: authenticationUser.name,
        lastName: authenticationUser.lastName,
        email: authenticationUser.email,
      );

  @override
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = User(name: '', lastName: '', email: '');
}
