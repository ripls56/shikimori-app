import 'package:shikimoriapp/core/error/exception.dart';
import 'package:shikimoriapp/feature/character/domain/models/character.dart';

///Character remote data source
abstract interface class CharacterRemoteDataSource {
  ///Get character details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<Character> getCharacterById(int id);
}
