import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';

class AddLikeUsecase {
  final FirebaseRepository repository;

  AddLikeUsecase(this.repository);

  Future<void> call(VideoEntity video) {
    return repository.addLike(video);
  }
}
