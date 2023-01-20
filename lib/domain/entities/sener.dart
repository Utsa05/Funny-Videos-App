import 'package:funny_zone_app/domain/entities/video_entity.dart';

class SenderEnity {
  final List<VideoEntity> videos;
  final String url;
  final String category;

  SenderEnity(
      {required this.videos, required this.url, required this.category});
}
