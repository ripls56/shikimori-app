import 'package:dio/dio.dart';
import 'package:shikimoriapp/constants.dart';
import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/data/models/character/character.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';
import 'character_remote_data_source.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;
  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<Character> getCharacterById(int id) async {
    var response = await dio.get('$HOST/characters/$id');
    if (response.statusCode == 200) {
      return CharacterModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
