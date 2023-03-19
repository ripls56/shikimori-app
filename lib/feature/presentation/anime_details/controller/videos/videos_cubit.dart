import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_videos.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit(this.getVideos) : super(VideosEmpty());

  final GetVideos getVideos;

  Future<void> getAllVideos(int id) async {
    try {
      final loadedOrFailure = await getVideos.call(GetVideosParams(id: id));
      loadedOrFailure.fold(
        (error) => {emit(VideosError(errorMessage: error.toString()))},
        (loaded) => {emit(VideosLoaded(videos: loaded))},
      );
    } catch (e) {
      emit(VideosError(errorMessage: e.toString()));
    }
  }
}
