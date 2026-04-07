import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';


part 'character.freezed.dart';
part 'character.g.dart';

@HiveType(typeId: 0)
@freezed
class Character with _$Character {
  const factory Character({
    @HiveField(0) required int id,
    @HiveField(1) required String name,
    @HiveField(2) required String status,
    @HiveField(3) required String species,
    @HiveField(4) required String location,
    @HiveField(5) required String imageUrl,
    @HiveField(6) @Default(false) bool isFavorite,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
