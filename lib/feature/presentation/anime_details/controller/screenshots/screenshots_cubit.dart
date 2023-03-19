import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/domain/entities/anime_details/anime_details.dart';
import 'package:shikimoriapp/feature/domain/use_cases/anime/get_screenshots.dart';

part 'screenshots_state.dart';

class ScreenshotsCubit extends Cubit<ScreenshotsState> {
  ScreenshotsCubit(this.getScreenshots) : super(ScreenshotsEmpty());

  final GetScreenshots getScreenshots;

  Future<void> getAllScreenshots(int id) async {
    try {
      emit(ScreenshotsEmpty());
      final loadedOrFailure =
          await getScreenshots.call(GetScreenshotsParams(id: id));
      loadedOrFailure.fold(
        (error) => {emit(ScreenshotsError(errorMessage: error.toString()))},
        (loaded) => {emit(ScreenshotsLoaded(screenshots: loaded))},
      );
    } catch (e) {
      emit(ScreenshotsError(errorMessage: e.toString()));
    }
  }
}
