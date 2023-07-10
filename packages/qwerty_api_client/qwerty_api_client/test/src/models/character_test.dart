import 'package:qwerty_api_client/qwerty_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('Character', () {
    test('supports value equality', () {
      const character1 = Character(
        name: 'name1',
        status: CharacterStatus.alive,
        species: 'species1',
        gender: CharacterGender.male,
        image: 'image1',
      );
      const character2 = Character(
        name: 'name2',
        status: CharacterStatus.alive,
        species: 'species2',
        gender: CharacterGender.male,
        image: 'image2',
      );
      const character3 = Character(
        name: 'name1',
        status: CharacterStatus.alive,
        species: 'species1',
        gender: CharacterGender.male,
        image: 'image1',
      );
      expect(character1, equals(character3));
      expect(character1, isNot(equals(character2)));
    });

    group('converts', () {
      const name = 'character name';
      const status = 'Alive';
      const species = 'character status';
      const gender = 'Female';
      const image = 'character image';
      const json = {
        'name': name,
        'status': status,
        'species': species,
        'gender': gender,
        'image': image,
      };
      test('a json object to an instance of itself', () {
        final character = Character.fromJson(json);
        expect(character.name, equals(name));
        expect(character.status, equals(CharacterStatus.alive));
        expect(character.species, equals(species));
        expect(character.gender, equals(CharacterGender.female));
        expect(character.image, equals(image));
      });

      test('itself to a json object', () {
        const character1 = Character(
          name: name,
          status: CharacterStatus.alive,
          species: species,
          gender: CharacterGender.female,
          image: image,
        );
        final character2 = Character.fromJson(json);
        expect(character1.toJson(), equals(character2.toJson()));
      });
    });
  });
}
