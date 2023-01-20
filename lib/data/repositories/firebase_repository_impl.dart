import 'package:funny_zone_app/data/datasource/firebase_remote_datasource.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/domain/entities/notification.dart';
import 'package:funny_zone_app/data/models/appinfo_model.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasource datasource;

  FirebaseRepositoryImpl({required this.datasource});
  @override
  Future<void> addLike(VideoEntity video) async {
    return datasource.addLike(video);
  }

  @override
  Future<AppInfoModel> getAppInfo() async {
    return datasource.getAppInfo();
  }

  @override
  Stream<List<NotificationEntity>> getNotifications() {
    return datasource.getNotifications();
  }

  @override
  Stream<List<VideoEntity>> getVideos() {
    return datasource.getVideos();
  }
}
