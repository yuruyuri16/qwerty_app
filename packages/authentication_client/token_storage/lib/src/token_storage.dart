import 'dart:convert';

import 'package:storage/storage.dart';
import 'package:token_storage/token_storage.dart';

/// Storage keys for the [TokenStorage].
abstract class TokenStorageKeys {
  /// OAuth2 token.
  static const token = '__oauth2_token__';
}

/// {@template token_storage}
/// Token storage
/// {@endtemplate}
class TokenStorage {
  /// {@macro token_storage}
  const TokenStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Reads the token from storage.
  Future<OAuth2Token?> read() async {
    final token = await _storage.read(key: TokenStorageKeys.token);
    if (token == null) return null;
    final json = jsonDecode(token) as Map<String, dynamic>;
    return OAuth2Token.fromJson(json);
  }

  /// Writes the provided [token] to the storage.
  Future<void> write(OAuth2Token token) async {
    final value = jsonEncode(token);
    await _storage.write(key: TokenStorageKeys.token, value: value);
  }

  /// Deletes the token from the storage.
  Future<void> delete() async {
    await _storage.delete(key: TokenStorageKeys.token);
  }
}
