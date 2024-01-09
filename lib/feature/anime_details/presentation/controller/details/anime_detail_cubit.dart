import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_roles.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_related.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_roles.dart';

part 'anime_detail_state.dart';

///Cubit for anime details
class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  ///Constructor
  AnimeDetailCubit(this._getAnimeById, this._getRelatedAnimes, this._getRoles)
      : super(
          AnimeDetailState.empty(),
        );

  final GetAnimeById _getAnimeById;
  final GetRelatedAnimes _getRelatedAnimes;

  final GetRoles _getRoles;

  ///Get anime details
  Future<void> getAnimeDetails(int id) async {
    try {
      emit(AnimeDetailState.empty());
      final animeDetails = await _getAnimeById.call(
        GetAnimeByIdParams(id: id),
      );
      final relatedAnimes = await _getRelatedAnimes.call(
        GetRelatedParams(id: id),
      );
      final roles = _foldRoles(
        await _getRoles.call(
          GetRolesParams(id: id),
        ),
      );

      animeDetails.fold(
        (error) => {
          emit(
            AnimeDetailState.error(
              errorMessage: error.toString(),
            ),
          ),
        },
        (loaded) async {
          final url = '${Env.shikimoriUrl}'
              '${loaded.image?.original}';
          final palette = await PaletteGenerator.fromImageProvider(
            ResizeImage(
              CachedNetworkImageProvider(url),
              height: 50,
              width: 50,
            ),
          );
          emit(
            AnimeDetailState.loaded(
              animeDetails: loaded,
              related: [],
              roles: roles,
              palette: palette,
            ),
          );
        },
      );
    } catch (ex) {
      emit(AnimeDetailError(errorMessage: ex.toString()));
      rethrow;
    }
  }

  List<AnimeDetailsRoles> _foldRoles(
    Either<Failure, List<AnimeDetailsRoles>> roles,
  ) {
    return roles.fold(
      (error) {
        emit(
          AnimeDetailState.error(
            errorMessage: error.toString(),
          ),
        );
        return List<AnimeDetailsRoles>.empty();
      },
      (loaded) {
        loaded.removeWhere((element) => element.character == null);
        return loaded;
      },
    );
  }
}
