// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:funny_zone_app/data/models/appinfo_model.dart';
import 'package:funny_zone_app/data/models/notification_model.dart';
import 'package:funny_zone_app/data/models/video_model.dart';
import 'package:funny_zone_app/domain/entities/notification.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseRemoteDatasource {
  Future<void> addLike(VideoEntity video);
  Stream<List<VideoEntity>> getVideos();
  Stream<List<NotificationEntity>> getNotifications();
  Future<AppInfoModel> getAppInfo();
}

class FirebaseRemoteDatasourceImpl implements FirebaseRemoteDatasource {
  final FirebaseFirestore firebaseFiresore;

  FirebaseRemoteDatasourceImpl({required this.firebaseFiresore});
  @override
  Future<void> addLike(VideoEntity video) async {
    final videoCollection = firebaseFiresore.collection("demo");

    videoCollection.doc(video.id).get().then((item) {
      if (item.exists) {
        final videoItem = VideoModel(
          category: video.category,
          like: video.like,
          id: video.id,
          videoLink: video.videoLink,
        ).toDocument();

        videoCollection
            .doc(video.id)
            .update(videoItem)
            .then((value) => print("like updated"));
      } else {
        print('videos not exist');
      }
    });
  }

  @override
  Stream<List<NotificationEntity>> getNotifications() {
    final collection = firebaseFiresore.collection("notifications");
    return collection.snapshots().map((event) =>
        event.docs.map((e) => NotificationModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<VideoEntity>> getVideos() {
    final collection = firebaseFiresore.collection("videos ");

    return collection
        //.orderBy('id')
        .snapshots()
        .map((event) => event.docs.map((e) {
              print(e.get('videoLink'));

              return VideoModel.fromSnapshot(e);
            }).toList());
  }

  @override
  Future<AppInfoModel> getAppInfo() async {
    final collection =
        firebaseFiresore.collection("appinfo").doc('WTmNxTYT7WDpzsTcijIX');

    return collection.get().then((value) {
      if (value.exists) {
        print(value.get('addstatus'));
        return AppInfoModel(
          addstatus: value.get('addstatus'),
          shareapp: value.get('shareapp'),
          othersapp: value.get('othersapp'),
          bannerad: value.get('bannerad'),
          interstitialad: value.get('interstitialad'),
          videoad: value.get('videoad'),
          policy: value.get('policy'),
        );
      } else {
        print('app info not exist');
        return const AppInfoModel(
          addstatus: 'nothing',
          bannerad: 'nothing',
          videoad: 'nothing',
          interstitialad: 'nothing',
          shareapp: 'nothing',
          othersapp: 'nothing',
        );
      }
    });
  }
}
