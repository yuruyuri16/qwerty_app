// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationUser _$AuthenticationUserFromJson(Map<String, dynamic> json) =>
    AuthenticationUser(
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$AuthenticationUserToJson(AuthenticationUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'last_name': instance.lastName,
      'email': instance.email,
    };
