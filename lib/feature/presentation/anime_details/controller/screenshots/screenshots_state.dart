part of 'screenshots_cubit.dart';

abstract class ScreenshotsState extends Equatable {
  const ScreenshotsState();

  @override
  List<Object> get props => [];
}

class ScreenshotsEmpty extends ScreenshotsState {}

class ScreenshotsError extends ScreenshotsState {
  final String errorMessage;

  const ScreenshotsError({required this.errorMessage});
}

class ScreenshotsLoaded extends ScreenshotsState {
  final List<Screenshot> screenshots;

  const ScreenshotsLoaded({required this.screenshots});
}
