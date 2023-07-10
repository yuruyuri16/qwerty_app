// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';

class FakeQwertyApiClient extends Fake implements QwertyApiClient {}

void main() {
  group('QwertyApiClient', () {
    test('can be implemented', () {
      expect(FakeQwertyApiClient.new, returnsNormally);
    });
  });

  group('exports', () {
    test('GetUserFailure', () {
      expect(() => GetUserFailure('oops'), returnsNormally);
    });

    test('GetCharactersFailure', () {
      expect(() => GetCharactersFailure('oops'), returnsNormally);
    });
  });
}
