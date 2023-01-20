// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? date;
  final String? time;

  const NotificationEntity({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
  });

  @override
  List<Object?> get props => [id, title];
}
