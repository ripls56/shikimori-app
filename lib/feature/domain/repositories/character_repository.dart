import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';

///Character repository
abstract interface class CharacterRepository {
  ///Get anime details with id
  Future<Either<Failure, Character>> getCharacterById(int id);
}
