import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/character/domain/models/character.dart';

///Character repository
abstract interface class CharacterRepository {
  ///Get anime details with id
  Future<Either<Failure, Character>> getCharacterById(int id);
}
