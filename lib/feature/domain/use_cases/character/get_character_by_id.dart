import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/core/usecase/usecase.dart';
import 'package:shikimoriapp/feature/domain/entities/character/character.dart';
import 'package:shikimoriapp/feature/domain/repositories/character_repository.dart';

class GetCharacterById extends UseCase<Character, GetCharacterByIdParams> {
  final CharacterRepository characterRepository;

  GetCharacterById(this.characterRepository);

  @override
  Future<Either<Failure, Character>> call(GetCharacterByIdParams params) async {
    return await characterRepository.getCharacterById(params.id);
  }
}

class GetCharacterByIdParams extends Equatable {
  final int id;

  const GetCharacterByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}