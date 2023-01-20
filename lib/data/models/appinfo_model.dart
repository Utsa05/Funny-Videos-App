// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:funny_zone_app/domain/entities/appinfo.dart';

class AppInfoModel extends AppInfoEntity {
  const AppInfoModel(
      {final String? addstatus,
      final String? bannerad,
      final String? interstitialad,
      final String? videoad,
      final String? shareapp,
      final String? othersapp,
      final String? policy})
      : super(
            addstatus: addstatus,
            bannerad: bannerad,
            interstitialad: interstitialad,
            videoad: videoad,
            shareapp: shareapp,
            othersapp: othersapp,
            policy: policy);

  factory AppInfoModel.fromSnapshot(DocumentSnapshot snapshot) {
    return AppInfoModel(
        addstatus: snapshot.get('addstatus'),
        bannerad: snapshot.get('bannerad'),
        interstitialad: snapshot.get('interstitialad'),
        videoad: snapshot.get('videoad'),
        shareapp: snapshot.get('shareapp'),
        othersapp: snapshot.get('othersapp'),
        policy: snapshot.get('policy'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'addstatus': addstatus,
      'bannerad': bannerad,
      'interstitialad': interstitialad,
      'videoad': videoad,
      'shareapp': shareapp,
      'othersapp': othersapp,
      'policy': policy,
    };
  }
}
