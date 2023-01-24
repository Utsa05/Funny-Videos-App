import 'package:funny_zone_app/domain/entities/appinfo.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';

class SenderEnity {
  final List<VideoEntity> videos;
  final String url;
  final AppInfoEntity info;
  final String category;

  SenderEnity(
      {required this.info,
      required this.videos,
      required this.url,
      required this.category});
}
