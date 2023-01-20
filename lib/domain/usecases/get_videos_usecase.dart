import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';

class GetVideosUsecase {
  final FirebaseRepository repository;

  GetVideosUsecase(this.repository);

  Stream<List<VideoEntity>> call() {
    return repository.getVideos();
  }
}
