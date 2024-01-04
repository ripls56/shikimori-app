import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shikimoriapp/env/env.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_anime_by_id.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_related.dart';
import 'package:shikimoriapp/feature/related/domain/models/related.dart';

part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> {
  AnimeDetailCubit(this.getAnimeById, this.getRelatedAnimes)
      : super(AnimeDetailEmpty());

  final GetAnimeById getAnimeById;
  final GetRelatedAnimes getRelatedAnimes;

  Future<void> getAnimeDetails(int id) async {
    try {
      emit(AnimeDetailEmpty());
      final animeDetails = await getAnimeById.call(
        GetAnimeByIdParams(id: id),
      );
      final relatedAnimes = await getRelatedAnimes.call(
        GetRelatedParams(id: id),
      );
      animeDetails.fold(
        (error) => {
          emit(
            AnimeDetailError(
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
            AnimeDetailLoaded(
              animeDetails: loaded,
              related: [],
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
}
