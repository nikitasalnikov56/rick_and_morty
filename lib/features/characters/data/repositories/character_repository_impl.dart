import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ricj_and_morti/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:ricj_and_morti/features/characters/domain/entities/character.dart';

abstract interface class CharacterRepository {
  CharacterRepository();

  Future<List<Character>> getCharacters(int page);
}

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;


  Box<Character> get _cacheBox => Hive.box<Character>('characters_box');

  CharacterRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Character>> getCharacters(int page) async {
    try {
      final models = await remoteDataSource.getCharacters(page);

      final remoteCharacters = models.map((m) => m.toEntity()).toList();

    
      for (var char in remoteCharacters) {
        final bool isAlreadyFavorite =
            _cacheBox.get(char.id)?.isFavorite ?? false;
        await _cacheBox.put(
          char.id,
          char.copyWith(isFavorite: isAlreadyFavorite),
        );
      }

      return remoteCharacters.map((e)=> _cacheBox.get(e.id)!).toList();
    } catch (e) {
      if (_cacheBox.isNotEmpty) {
        return _cacheBox.values.toList();
      }

      rethrow;
    }
  }
}
