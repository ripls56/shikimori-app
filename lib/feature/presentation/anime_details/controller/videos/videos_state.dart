part of 'videos_cubit.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosEmpty extends VideosState {}

class VideosError extends VideosState {
  final String errorMessage;

  const VideosError({required this.errorMessage});
}

class VideosLoaded extends VideosState {
  final List<Video> videos;

  const VideosLoaded({required this.videos});
}
