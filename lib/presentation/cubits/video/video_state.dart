part of 'video_cubit.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoNoInternet extends VideoState {}

class VideoFailure extends VideoState {}

class VideoLoaded extends VideoState {
  final List<VideoEntity> videos;

  VideoLoaded({required this.videos});
}
