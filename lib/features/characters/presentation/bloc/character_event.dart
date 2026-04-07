import 'package:freezed_annotation/freezed_annotation.dart';
part 'character_event.freezed.dart';

@freezed
class CharacterEvent with _$CharacterEvent {
  const factory CharacterEvent.fetchCharacters({
    @Default(false) bool isRefresh,
    String? name,
  }) = FetchCharacters;
  const factory CharacterEvent.toggleFavorite(int id) = ToggleFavorite;
}
