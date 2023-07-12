// ignore_for_file: prefer_const_constructors
import 'package:dio_authentication_client/dio_authentication_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJWTInterceptor extends Mock implements JWTInterceptor {}

void main() {
  // group('DioAuthenticationClient', () {
  //   late JWTInterceptor jwtInterceptor;
  //   late DioAuthenticationClient authenticationClient;

  //   setUp(() {
  //     jwtInterceptor = MockJWTInterceptor();
  //     authenticationClient = DioAuthenticationClient(
  //       jwtInterceptor: jwtInterceptor,
  //     );
  //   });

  //   test('can be instantiated', () {
  //     expect(
  //       authenticationClient,
  //       isNotNull,
  //     );
  //   });
  // });
}
