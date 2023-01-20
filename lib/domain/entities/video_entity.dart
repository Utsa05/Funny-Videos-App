// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart' show Equatable;

class VideoEntity extends Equatable {
  final String category;
  final String id;
  final String like;
  final String videoLink;

  const VideoEntity(
      {required this.category,
      required this.id,
      required this.like,
      required this.videoLink});

  @override
  List<Object?> get props => [id, videoLink];
}
