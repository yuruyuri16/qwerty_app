// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FakeAuthenticationClient extends Fake implements AuthenticationClient {}

void main() {
  group('AuthenticationClient', () {
    test('can be implemented', () {
      expect(FakeAuthenticationClient.new, returnsNormally);
    });
  });

  group('exports', () {
    test('LogInWithEmailAndPasswordFailure', () {
      expect(() => LogInWithEmailAndPasswordFailure('oops'), returnsNormally);
    });

    test('RegisterFailure', () {
      expect(() => RegisterFailure('oops'), returnsNormally);
    });

    test('LogOutFailure', () {
      expect(() => LogOutFailure('oops'), returnsNormally);
    });
  });

  group('AuthenticationStatus', () {
    late AuthenticationStatus authenticationStatus;
    group('isAuthenticated', () {
      test('should return false when status is unauthenticated', () {
        authenticationStatus = AuthenticationStatus.unauthenticated;
        expect(authenticationStatus.isAuthenticated, isFalse);
      });

      test('should return true when status is authenticated', () {
        authenticationStatus = AuthenticationStatus.authenticated;
        expect(authenticationStatus.isAuthenticated, isTrue);
      });
    });

    group('isUnauthenticated', () {
      test('should return true when status is unauthenticated', () {
        authenticationStatus = AuthenticationStatus.unauthenticated;
        expect(authenticationStatus.isUnauthenticated, isTrue);
      });

      test('should return false when status is authenticated', () {
        authenticationStatus = AuthenticationStatus.authenticated;
        expect(authenticationStatus.isUnauthenticated, isFalse);
      });
    });
  });
}
