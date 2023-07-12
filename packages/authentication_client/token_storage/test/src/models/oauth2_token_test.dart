// ignore_for_file: prefer_const_constructors

import 'package:test/test.dart';
import 'package:token_storage/token_storage.dart';

void main() {
  group('OAuth2Token', () {
    test('tokenType defaults to Bearer', () {
      expect(OAuth2Token(accessToken: 'token').tokenType, equals('Bearer'));
    });

    test('supports value equality', () {
      final token1 = OAuth2Token(accessToken: 'token');
      final token2 = OAuth2Token(accessToken: 'token');
      final token3 = OAuth2Token(accessToken: 'nekot');
      expect(token1, equals(token2));
      expect(token1, isNot(equals(token3)));
    });

    group('converts', () {
      const accessToken = 'token';
      const refreshToken = 'refreshToken';
      final tokenMap = {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_in': null,
        'scope': null,
        'token_type': 'Bearer',
      };
      final token = OAuth2Token.fromJson(tokenMap);

      test('a json object to an instance of itself', () {
        expect(token.accessToken, equals(accessToken));
        expect(token.refreshToken, equals(refreshToken));
      });

      test('itself to a json object', () {
        expect(token.toJson(), equals(tokenMap));
      });
    });
  });
}
