import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';

///Character remote data source
abstract interface class CharacterRemoteDataSource {
  ///Get character details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<Character> getCharacterById(int id);
}
