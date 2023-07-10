// ignore_for_file: prefer_const_constructors
import 'package:dio/dio.dart';
import 'package:dio_qwerty_api_client/dio_qwerty_api_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('DioQwertyApiClient', () {
    group('default constructor', () {
      late Dio httpClient;
      late DioQwertyApiClient apiClient;

      setUp(() {
        httpClient = MockDio();
      });

      test('can be instantiated (no params)', () {
        apiClient = DioQwertyApiClient();
        expect(() => apiClient, returnsNormally);
      });

      test('can be instantiated (with params)', () {
        apiClient = DioQwertyApiClient(httpClient: httpClient);
        expect(() => apiClient, returnsNormally);
      });
    });

    group('getUser', () {
      late Dio httpClient;
      late QwertyApiClient apiClient;

      setUp(() {
        httpClient = MockDio();
        apiClient = DioQwertyApiClient(httpClient: httpClient);
      });

      test('makes correct http request', () async {
        const data = {
          'name': 'mock name',
          'last_name': 'mock last name',
          'email': 'mock email',
        };
        when(() => httpClient.get<Map<String, dynamic>>(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
            data: data,
          ),
        );

        await apiClient.getUser();

        verify(() => httpClient.get<Map<String, dynamic>>(any())).called(1);
      });

      test(
          'throw GetUserFailure '
          'when response has a non-200 status code', () {
        when(() => httpClient.get<Map<String, dynamic>>(any()))
            .thenThrow(DioException(requestOptions: RequestOptions()));

        expect(() => apiClient.getUser(), throwsA(isA<GetUserFailure>()));
      });

      test(
          'throws GetUserFailure '
          'when response body is null', () {
        when(() => httpClient.get<Map<String, dynamic>>(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        );
        expect(
          () => apiClient.getUser(),
          throwsA(isA<GetUserFailure>()),
        );
      });
    });

    group('getCharacters', () {
      late Dio httpClient;
      late QwertyApiClient apiClient;

      setUp(() {
        httpClient = MockDio();
        apiClient = DioQwertyApiClient(httpClient: httpClient);
      });

      test('makes correct http request (no query params)', () async {
        final data = [
          {
            'name': 'mock name',
            'status': 'Alive',
            'species': 'mock species',
            'gender': 'Male',
            'image': 'mock image',
          }
        ];
        final queryParameters = {'page': 1};
        when(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(data: data),
            statusCode: 200,
            data: data,
          ),
        );
        await apiClient.getCharacters();
        verify(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: queryParameters,
          ),
        ).called(1);
      });

      test('makes correct http request (with query params)', () async {
        final data = [
          {
            'name': 'mock name',
            'status': 'Alive',
            'species': 'mock species',
            'gender': 'Male',
            'image': 'mock image',
          }
        ];
        final queryParameters = {'page': 10};
        when(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(data: data),
            statusCode: 200,
            data: data,
          ),
        );
        await apiClient.getCharacters(page: 10);
        verify(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: queryParameters,
          ),
        ).called(1);
      });

      test(
          'throws GetCharactersFailure '
          'when response has a non-200 status code', () {
        when(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(DioException(requestOptions: RequestOptions()));
        expect(
          () => apiClient.getCharacters(),
          throwsA(isA<GetCharactersFailure>()),
        );
      });

      test(
          'throws GetCharactersFailure '
          'when response body is null', () {
        when(
          () => httpClient.get<List<dynamic>>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        );
        expect(
          () => apiClient.getCharacters(),
          throwsA(isA<GetCharactersFailure>()),
        );
      });
    });
  });
}
