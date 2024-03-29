import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/character/data/datasources/character_remote_data_source.dart';
import 'package:shikimoriapp/feature/character/domain/models/character.dart';
import 'package:shikimoriapp/feature/character/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl(this.characterRemoteDataSource);
  final CharacterRemoteDataSource characterRemoteDataSource;

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    return await _getCharacterById(
      () => characterRemoteDataSource.getCharacterById(id),
    );
  }

  Future<Either<Failure, Character>> _getCharacterById(
    Future<Character> Function() character,
  ) async {
    try {
      final model = await character();
      return Right(model);
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
