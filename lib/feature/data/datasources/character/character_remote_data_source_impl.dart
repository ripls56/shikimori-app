import 'package:dio/dio.dart';
import 'package:shikimoriapp/core/endpoints/api_endpoints.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/datasources/character/character_remote_data_source.dart';
import 'package:shikimoriapp/feature/data/models/character/character.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';

///Character repository implementation
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  ///Need dio client to work
  CharacterRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Character> getCharacterById(int id) async {
    final response = await _dio.get(ApiEndpoints.characterById(id));
    if (response.statusCode == 200) {
      return CharacterModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
