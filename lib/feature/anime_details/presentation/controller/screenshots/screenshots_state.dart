part of 'screenshots_cubit.dart';

abstract class ScreenshotsState extends Equatable {
  const ScreenshotsState();

  @override
  List<Object> get props => [];
}

class ScreenshotsEmpty extends ScreenshotsState {}

class ScreenshotsError extends ScreenshotsState {
  const ScreenshotsError({required this.errorMessage});
  final String errorMessage;
}

class ScreenshotsLoaded extends ScreenshotsState {
  const ScreenshotsLoaded({required this.screenshots});
  final List<AnimeDetailsScreenshot> screenshots;
}
