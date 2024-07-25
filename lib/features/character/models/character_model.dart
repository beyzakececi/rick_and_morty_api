import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/locations/models/character_location_model.dart';
import 'package:rick_and_morty/features/locations/models/origin_model.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;

  Origin origin;
  CharacterLocation location;

  final String image;
  final List<String> episode;
  final String url;
  final String created;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}


@JsonSerializable()
class ListCharacterModel {
  final List<CharacterModel> results;

  ListCharacterModel({
    required this.results,
  });

  // Factory constructor to create a ListCharacterModel from JSON
  factory ListCharacterModel.fromJson(Map<String, dynamic> json) =>
      _$ListCharacterModelFromJson(json);

  // Method to convert ListCharacterModel to JSON
  Map<String, dynamic> toJson() => _$ListCharacterModelToJson(this);

  // CopyWith method to create a new instance with modified fields
  ListCharacterModel copyWith({
    List<CharacterModel>? results,
  }) {
    return ListCharacterModel(
      results: results ?? this.results,
    );
  }
}