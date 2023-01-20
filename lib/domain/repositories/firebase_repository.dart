import 'package:funny_zone_app/data/models/appinfo_model.dart';
import 'package:funny_zone_app/domain/entities/notification.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';

abstract class FirebaseRepository {
  Future<void> addLike(VideoEntity video);
  Stream<List<VideoEntity>> getVideos();
  Stream<List<NotificationEntity>> getNotifications();
  Future<AppInfoModel> getAppInfo();
}
