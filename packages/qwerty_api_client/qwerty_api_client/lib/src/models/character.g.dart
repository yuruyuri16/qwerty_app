// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      status: $enumDecode(_$CharacterStatusEnumMap, json['status']),
      species: json['species'] as String,
      gender: $enumDecode(_$CharacterGenderEnumMap, json['gender']),
      image: json['image'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'status': _$CharacterStatusEnumMap[instance.status]!,
      'species': instance.species,
      'gender': _$CharacterGenderEnumMap[instance.gender]!,
      'image': instance.image,
    };

const _$CharacterStatusEnumMap = {
  CharacterStatus.alive: 'Alive',
  CharacterStatus.dead: 'Dead',
  CharacterStatus.unknown: 'unknown',
};

const _$CharacterGenderEnumMap = {
  CharacterGender.female: 'Female',
  CharacterGender.male: 'Male',
  CharacterGender.genderless: 'Genderless',
  CharacterGender.unknown: 'unknown',
};
