// ignore_for_file: prefer_const_constructors

import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('User', () {
    group('fromAuthenticationUser', () {
      test('initialize correctly', () {
        const name = 'Jose';
        const lastName = 'Perez';
        const email = 'test@dev.com';
        const authenticationUser = AuthenticationUser(
          name: name,
          lastName: lastName,
          email: email,
        );
        expect(
          User.fromAuthenticatedUser(authenticationUser: authenticationUser),
          equals(User(name: name, lastName: lastName, email: email)),
        );
      });
    });

    group('isAnonymous', () {
      test('sets is Anonymous correctly', () {
        const user = User.anonymous;
        expect(user.isAnonymous, isTrue);
      });
    });
  });
}
