import 'package:shikimoriapp/feature/domain/entities/character/character.dart';

abstract class CharacterRemoteDataSource {
  ///Get character details with id
  ///
  ///Throws [ServerException] for all code errors
  Future<Character> getCharacterById(int id);
}
