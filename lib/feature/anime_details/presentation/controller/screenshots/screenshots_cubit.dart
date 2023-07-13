import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimoriapp/feature/anime_details/domain/models/anime_details_screenshot.dart';
import 'package:shikimoriapp/feature/anime_details/domain/use_cases/get_screenshots.dart';

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
      rethrow;
    }
  }
}
