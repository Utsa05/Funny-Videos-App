// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:funny_zone_app/domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {final String? id,
      final String? title,
      final String? description,
      final String? date,
      final String? time})
      : super(
          id: id,
          title: title,
          description: description,
          date: date,
          time: time,
        );

  factory NotificationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return NotificationModel(
      id: snapshot.get('id'),
      title: snapshot.get('title'),
      description: snapshot.get('description'),
      date: snapshot.get('date') ?? "",
      time: snapshot.get('time'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time
    };
  }
}
