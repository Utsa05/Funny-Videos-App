// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:meta/meta.dart';

part 'releted_state.dart';

class ReletedCubit extends Cubit<ReletedState> {
  ReletedCubit() : super(ReletedInitial());

  void loadReletedVideo(List<VideoEntity> videos) {
    emit(ReletedLoading());

    emit(ReletedLoaded(videos: videos));
  }
}
