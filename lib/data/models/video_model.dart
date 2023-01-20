// ignore_for_file: depend_on_referenced_packages

import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel extends VideoEntity {
  const VideoModel(
      {required final String category,
      required final String id,
      required final String like,
      required final String videoLink})
      : super(category: category, id: id, like: like, videoLink: videoLink);

  factory VideoModel.fromSnapshot(DocumentSnapshot snapshot) {
    return VideoModel(
        category: snapshot.get('category'),
        id: snapshot.get('id'),
        like: snapshot.get('like').toString(),
        videoLink: snapshot.get('videoLink'));
  }
  Map<String, dynamic> toDocument() {
    return {
      'category': category,
      'id': id,
      "like": like,
      "videoLink": videoLink
    };
  }
}
