import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'oauth2_token.g.dart';

/// {@template oauth2_token}
/// Standard OAuth2Token as defined by
/// https://www.oauth.com/oauth2-servers/access-tokens/access-token-response/
/// {@endtemplate}
@JsonSerializable()
class OAuth2Token extends Equatable {
  /// {macro oauth2_token}
  const OAuth2Token({
    required this.accessToken,
    this.tokenType = 'Bearer',
    this.expiresIn,
    this.refreshToken,
    this.scope,
  });

  /// Converts a `Map<String, dynamic>` into a [OAuth2Token] instance.
  factory OAuth2Token.fromJson(Map<String, dynamic> json) =>
      _$OAuth2TokenFromJson(json);

  /// The access token string as issued by the authorization server.
  @JsonKey(name: 'access_token')
  final String accessToken;

  /// The type of token this is, typically just the string “bearer”.
  @JsonKey(name: 'token_type')
  final String? tokenType;

  /// If the access token expires, the server should reply
  /// with the duration of time the access token is granted for.
  @JsonKey(name: 'expires_in')
  final int? expiresIn;

  /// Token which applications can use to obtain another access token.
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  /// Application scope granted as defined in https://oauth.net/2/scope
  final String? scope;

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
        expiresIn,
        refreshToken,
        scope,
      ];

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$OAuth2TokenToJson(this);
}
