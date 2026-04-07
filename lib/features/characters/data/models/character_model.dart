import 'package:json_annotation/json_annotation.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';


part 'character_model.g.dart';

@JsonSerializable()
class CharacterResponse {
  final CharacterInfo info;
  final List<CharacterModel> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) => 
      _$CharacterResponseFromJson(json);
}

@JsonSerializable()
class CharacterInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharacterInfo({required this.count, required this.pages, this.next, this.prev});

  factory CharacterInfo.fromJson(Map<String, dynamic> json) => 
      _$CharacterInfoFromJson(json);
}

@JsonSerializable()
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final LocationModel location;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.location,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => 
      _$CharacterModelFromJson(json);

 
  Character toEntity() {
    return Character(
      id: id,
      name: name,
      imageUrl: image,
      status: status,
      species: species,
      location: location.name,
      isFavorite: false,
    );
  }
}

@JsonSerializable()
class LocationModel {
  final String name;
  LocationModel({required this.name});
  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);
}