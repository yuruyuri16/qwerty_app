// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:test/test.dart';

class MockQwertyApiClient extends Mock implements QwertyApiClient {}

void main() {
  group('RickAndMortyRepository', () {
    late QwertyApiClient apiClient;
    late RickAndMortyRepository rickAndMortyRepository;

    setUp(() {
      apiClient = MockQwertyApiClient();
      rickAndMortyRepository = RickAndMortyRepository(apiClient: apiClient);
    });

    test('can be instantiated', () {
      expect(RickAndMortyRepository(apiClient: apiClient), isNotNull);
    });

    group('getCharacters', () {
      test('call getCharacters on QwertyApiClient', () async {
        when(() => apiClient.getCharacters()).thenAnswer((_) async => []);
        await rickAndMortyRepository.getCharacters();
        verify(() => apiClient.getCharacters()).called(1);
      });

      test('rethrows GetCharactersFailure', () {
        when(() => apiClient.getCharacters())
            .thenThrow(GetCharactersFailure(''));
        expect(
          rickAndMortyRepository.getCharacters(),
          throwsA(isA<GetCharactersFailure>()),
        );
      });

      test('throws GetCharactersFailure on generic exception', () {
        when(() => apiClient.getCharacters()).thenThrow(Exception());
        expect(
          rickAndMortyRepository.getCharacters(),
          throwsA(isA<GetCharactersFailure>()),
        );
      });
    });
  });
}
