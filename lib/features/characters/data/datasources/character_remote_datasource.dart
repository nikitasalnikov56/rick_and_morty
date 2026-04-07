import 'package:dio/dio.dart';
import 'package:ricj_and_morti/features/characters/data/models/character_model.dart';

class CharacterRemoteDataSource {
  final Dio _dio;
  CharacterRemoteDataSource(this._dio);

  Future<List<CharacterModel>> getCharacters(
    int page, {
    String? name,
    String? status,
    String? gender,
  }) async {
    final response = await _dio.get(
      '/character',
      queryParameters: {
        'page': page,
        if (name != null && name.isNotEmpty) 'name': name,
        if (status != null && status.isNotEmpty) 'status': status,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
      },
    );

    if (response.statusCode == 200) {
      final data = CharacterResponse.fromJson(response.data);
      return data.results;
    } else {
      throw Exception('Server Error');
    }
  }
}
