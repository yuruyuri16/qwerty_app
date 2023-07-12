// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';
import 'package:test/test.dart';
import 'package:token_storage/token_storage.dart';

class FakeTokenStorage extends Fake implements TokenStorage {}

class MockStorage extends Mock implements Storage {}

void main() {
  group('TokenStorage', () {
    late Storage storage;
    late TokenStorage tokenStorage;

    const tokenMap = {'access_token': 'token'};
    final tokenString = jsonEncode(tokenMap);
    final token = OAuth2Token.fromJson(tokenMap);

    setUp(() {
      storage = MockStorage();
      tokenStorage = TokenStorage(storage: storage);
    });
    test('can be implemented', () {
      expect(FakeTokenStorage.new, returnsNormally);
    });

    group('read', () {
      test(
          'returns null '
          'when no token is saved', () async {
        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => null);
        expect(await tokenStorage.read(), isNull);
      });

      test(
          'returns token '
          'when token is saved', () async {
        const tokenMap = {'access_token': 'token'};
        final tokenString = jsonEncode(tokenMap);
        final token = OAuth2Token.fromJson(tokenMap);
        when(() => storage.read(key: any(named: 'key')))
            .thenAnswer((_) async => tokenString);
        expect(await tokenStorage.read(), equals(token));
      });
    });

    group('write', () {
      test('returns', () {
        when(
          () => storage.write(
            key: any(named: 'key'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async {});
        expect(tokenStorage.write(token), completes);
      });
    });

    group('delete', () {
      test('test name', () {
        when(() => storage.delete(key: any(named: 'key')))
            .thenAnswer((_) async {});
        expect(tokenStorage.delete(), completes);
      });
    });
  });
}
