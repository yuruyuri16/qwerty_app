// ignore_for_file: prefer_const_constructors
import 'package:authentication_client/authentication_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockQwertyApiClient extends Mock implements QwertyApiClient {}

void main() {
  group('UserRepository', () {
    late AuthenticationClient authenticationClient;
    late QwertyApiClient apiClient;
    late UserRepository userRepository;

    setUp(() {
      authenticationClient = MockAuthenticationClient();
      apiClient = MockQwertyApiClient();
      userRepository = UserRepository(
        authenticationClient: authenticationClient,
        apiClient: apiClient,
      );
    });

    test('can be instantiated', () {
      expect(userRepository, isNotNull);
    });

    group('user', () {
      const authenticationUser = AuthenticationUser(
        name: 'mock name',
        lastName: 'mock last name',
        email: 'mock email',
      );
      final user = User.fromAuthenticatedUser(
        authenticationUser: authenticationUser,
      );

      test(
          'emits anonymous user when initialized '
          'and authenticationClient.authenticationStatus is unauthenticated',
          () async {
        when(() => authenticationClient.authenticationStatus).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.unauthenticated),
        );
        expect(await userRepository.user.first, equals(User.anonymous));
      });

      test(
          'emits a user instance when initialized '
          'and authenticationClient.authenticationStatus '
          'is authenticated', () async {
        when(() => authenticationClient.authenticationStatus).thenAnswer(
          (_) => Stream.value(AuthenticationStatus.authenticated),
        );
        when(() => apiClient.getUser()).thenAnswer(
          (_) async => authenticationUser,
        );
        expect(await userRepository.user.first, equals(user));
      });
    });

    group('logInWithEmailAndPassword', () {
      const email = 'email';
      const password = 'secretpassword';
      test('calls logInWithEmailAndPassword on AuthenticationClient', () async {
        when(
          () => authenticationClient.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {});
        await userRepository.logInWithEmailAndPassword(
          email: email,
          password: password,
        );
        verify(
          () => authenticationClient.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('rethrows LogInWithEmailAndPasswordFailure', () async {
        when(
          () => authenticationClient.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(LogInWithEmailAndPasswordFailure(''));
        expect(
          userRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<LogInWithEmailAndPasswordFailure>()),
        );
      });

      test('throws LogInWithEmailAndPasswordFailure on generic exception', () {
        when(
          () => authenticationClient.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        expect(
          userRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<LogInWithEmailAndPasswordFailure>()),
        );
      });
    });

    group('register', () {
      const name = 'name';
      const lastName = 'lastName';
      const email = 'email';
      const password = 'password';

      test('calls register on AuthenticationClient', () async {
        when(
          () => authenticationClient.register(
            name: any(named: 'name'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async {});
        await userRepository.register(
          name: name,
          lastName: lastName,
          email: email,
          password: password,
        );
        verify(
          () => authenticationClient.register(
            name: name,
            lastName: lastName,
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('rethrows RegisterFailure', () {
        when(
          () => authenticationClient.register(
            name: any(named: 'name'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(RegisterFailure(''));
        expect(
          userRepository.register(
            name: name,
            lastName: lastName,
            email: email,
            password: password,
          ),
          throwsA(isA<RegisterFailure>()),
        );
      });

      test('throws RegisterFailure on generic exception.', () {
        when(
          () => authenticationClient.register(
            name: name,
            lastName: lastName,
            email: email,
            password: password,
          ),
        ).thenThrow(Exception());
        expect(
          userRepository.register(
            name: name,
            lastName: lastName,
            email: email,
            password: password,
          ),
          throwsA(isA<RegisterFailure>()),
        );
      });
    });

    group('logOut', () {
      test('calls logOut on AuthenticationClient', () async {
        when(() => authenticationClient.logOut()).thenAnswer((_) async {});
        await userRepository.logOut();
        verify(() => authenticationClient.logOut()).called(1);
      });

      test('rethrows LogOutFailure', () async {
        when(() => authenticationClient.logOut()).thenThrow(LogOutFailure(''));
        expect(userRepository.logOut(), throwsA(isA<LogOutFailure>()));
      });

      test('throws LogOutFailure on generic exception', () {
        when(() => authenticationClient.logOut()).thenThrow(Exception());
        expect(userRepository.logOut(), throwsA(isA<LogOutFailure>()));
      });
    });
  });
}
