// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth2_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuth2Token _$OAuth2TokenFromJson(Map<String, dynamic> json) => OAuth2Token(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
      expiresIn: json['expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$OAuth2TokenToJson(OAuth2Token instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'scope': instance.scope,
    };
