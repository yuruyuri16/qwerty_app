import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

/// The status of the character.
enum CharacterStatus {
  /// Alive status.
  @JsonValue('Alive')
  alive,

  /// Dead status.
  @JsonValue('Dead')
  dead,

  /// Unknown status.
  @JsonValue('unknown')
  unknown;
}

/// The gender of the character.
enum CharacterGender {
  /// Female gender.
  @JsonValue('Female')
  female,

  /// Male gender.
  @JsonValue('Male')
  male,

  /// Genderless gender.
  @JsonValue('Genderless')
  genderless,

  /// Unknown gender.
  @JsonValue('unknown')
  unknown;
}

/// {@template character}
/// Character model.
/// {@endtemplate}
@JsonSerializable()
class Character extends Equatable {
  /// {@macro character}
  const Character({
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  /// Converts a `Map<String, dynamic>` into a [Character] instance.
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// The name of the character.
  final String name;

  /// The status of the character.
  final CharacterStatus status;

  /// The species of the character.
  final String species;

  /// The gender of the character.
  final CharacterGender gender;

  /// Link to the character's image.
  final String image;

  @override
  List<Object> get props => [name, status, species, gender, image];

  /// Converts the current instance to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
