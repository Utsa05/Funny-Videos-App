// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/appinfo.dart';
import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoGrid extends StatelessWidget {
  const VideoGrid({
    Key? key,
    this.isToFavorite,
    required this.videos,
    required this.allvideos,
    required this.info,
  }) : super(key: key);

  final bool? isToFavorite;
  final List<VideoEntity> videos;
  final List<VideoEntity> allvideos;
  final AppInfoEntity info;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: videos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 110.0,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              VideoGridItem(
                video: videos[index],
                tap: () {
                  Navigator.pushNamed(context, AppString.viewvideo,
                      arguments: SenderEnity(
                          info: info,
                          videos: allvideos,
                          url: videos[index].videoLink,
                          category: videos[index].category));
                },
              ),
              isToFavorite == true
                  ? MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      padding: const EdgeInsets.all(0.0),
                      color: AppColor.black.withOpacity(0.3),
                      height: 30.0,
                      minWidth: 10,
                      onPressed: () {},
                      child: const Icon(
                        Icons.delete,
                        color: AppColor.white,
                      ))
                  : const SizedBox()
            ],
          );
        });
  }
}

class VideoGridItem extends StatelessWidget {
  const VideoGridItem({
    Key? key,
    required this.video,
    required this.tap,
  }) : super(key: key);
  final VideoEntity video;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    String id = YoutubePlayer.convertUrlToId(video.videoLink).toString();
    return CachedNetworkImage(
      imageUrl: 'https://img.youtube.com/vi/$id/0.jpg',
      placeholder: (context, url) => const Center(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: CircularProgressIndicator(
          color: AppColor.gold,
        ),
      )),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              borderRadius: BorderRadius.circular(6.0),
              onTap: tap,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Icon(
                    Icons.play_arrow,
                    color: AppColor.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
