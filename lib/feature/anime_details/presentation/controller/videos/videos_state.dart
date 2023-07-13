part of 'videos_cubit.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosEmpty extends VideosState {}

class VideosError extends VideosState {
  const VideosError({required this.errorMessage});
  final String errorMessage;
}

class VideosLoaded extends VideosState {
  const VideosLoaded({required this.videos});
  final List<AnimeDetailsVideo> videos;
}
