import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_user.g.dart';

/// {@template authentication_user}
/// {@endtemplate}
@JsonSerializable()
class AuthenticationUser extends Equatable {
  /// {@macro authentication_user}
  const AuthenticationUser({
    required this.name,
    required this.lastName,
    required this.email,
  });

  /// Converts a `Map<String, dynamic>` into a [AuthenticationUser] instance.
  factory AuthenticationUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationUserFromJson(json);

  /// The current user's name.
  final String name;

  /// The current user's last name.
  @JsonKey(name: 'last_name')
  final String lastName;

  /// The current user's email address.
  final String email;

  /// Whether the current user is anonymous.
  bool get isAnonymous => this == anonymous;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = AuthenticationUser(
    name: '',
    lastName: '',
    email: '',
  );

  @override
  List<Object> get props => [name, lastName, email];

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$AuthenticationUserToJson(this);
}
