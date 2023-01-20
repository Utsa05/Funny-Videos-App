// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/domain/usecases/get_videos_usecase.dart';
import 'package:meta/meta.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideosUsecase videosUsecase;
  VideoCubit({required this.videosUsecase}) : super(VideoInitial());

  Future<void> getVideos() async {
    print('video calling');

    try {
      emit(VideoLoading());
      final videoResponse = videosUsecase.call();
      videoResponse.listen((videos) {
        print(videos.length);
        emit(VideoLoaded(videos: videos));
        print('success');
      });
    } on SocketException {
      print('no internet');
      emit(VideoNoInternet());
    } catch (e) {
      print('error');
      emit(VideoFailure());
    }
  }
}
