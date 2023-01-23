part of 'releted_cubit.dart';

@immutable
abstract class ReletedState {}

class ReletedInitial extends ReletedState {}

class ReletedLoading extends ReletedState {}

class ReletedLoaded extends ReletedState {
  final List<VideoEntity> videos;

  ReletedLoaded({required this.videos});
}
