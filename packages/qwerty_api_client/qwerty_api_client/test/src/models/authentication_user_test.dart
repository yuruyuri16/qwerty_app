import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('AuthenticationUser', () {
    test('supports value equality', () {
      const userA = AuthenticationUser(
        name: 'A',
        lastName: 'A',
        email: 'A',
      );
      const secondUserA = AuthenticationUser(
        name: 'A',
        lastName: 'A',
        email: 'A',
      );
      const userB = AuthenticationUser.anonymous;

      expect(userA, equals(secondUserA));
      expect(userA, isNot(equals(userB)));
    });

    group('converts', () {
      const name = 'user name';
      const lastName = 'user last name';
      const email = 'user email';
      const json = {
        'name': name,
        'last_name': lastName,
        'email': email,
      };

      test('a json object to an instance of itself', () {
        final authenticationUser = AuthenticationUser.fromJson(json);
        expect(authenticationUser.name, equals(name));
        expect(authenticationUser.lastName, equals(lastName));
        expect(authenticationUser.email, equals(email));
      });

      test('itself to a json object', () {
        const authenticationUser = AuthenticationUser(
          name: name,
          lastName: lastName,
          email: email,
        );
        expect(authenticationUser.toJson(), equals(json));
      });
    });

    test('isAnonymous returns true for anonymous user', () {
      expect(AuthenticationUser.anonymous.isAnonymous, isTrue);
    });
  });
}
