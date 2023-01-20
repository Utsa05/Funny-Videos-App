// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:youtube_video_info/youtube_video_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({super.key, required this.senderEnity});
  final SenderEnity senderEnity;

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late YoutubePlayerController _controller;
  bool isVideoInfoLoading = true;
  YoutubeDataModel? videoData;
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.senderEnity.url).toString(),
      flags: const YoutubePlayerFlags(
          autoPlay: true,
          hideThumbnail: false,
          hideControls: false,
          showLiveFullscreenButton: true),
    );
    getVideoInfo(widget.senderEnity.url);

    super.initState();
  }

  bool isForinfinitytime = false;

  getVideoInfo(String url) async {
    isVideoInfoLoading = true;
    videoData = await YoutubeData.getData(url);
    print("HI :");
    print(videoData!.authorName);
    print(videoData!.url);
    isVideoInfoLoading = false;

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  // _controller.load(YoutubePlayer.convertUrlToId(
  //               "https://youtu.be/k6eyzRda9zU?list=RDMMcZZDrkPmvKc")
  //           .toString());
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    List<VideoEntity> getCategorybyVideo(String category) {
      List<VideoEntity> list = [];
      for (var video in widget.senderEnity.videos) {
        if (video.category.toLowerCase().toString() == category.toLowerCase()) {
          list.add(video);
        }
      }
      return list;
    }

    List<VideoEntity> reletedVideos =
        getCategorybyVideo(widget.senderEnity.category);
    List<VideoEntity> mostviewsVideos = getCategorybyVideo("Most viewed");
    List<VideoEntity> trandingVideos = getCategorybyVideo("Tranding");
    return Scaffold(
        key: key,

        //1
        body: Column(
          //shrinkWrap: true,

          children: [
            // isVideoInfoLoading == false
            //     ?
            YoutubePlayerBuilder(
                onEnterFullScreen: () {
                  print("full screen");
                  setState(() {
                    isFullScreen = true;
                  });
                },
                onExitFullScreen: (() {
                  print("off full screen");
                  setState(() {
                    isFullScreen = false;
                  });
                }),
                player: YoutubePlayer(
                  progressIndicatorColor: AppColor.gold,
                  controller: _controller,
                  progressColors: const ProgressBarColors(
                      handleColor: AppColor.white,
                      bufferedColor: AppColor.gold,
                      backgroundColor: AppColor.white,
                      playedColor: AppColor.gold),
                ),
                builder: (context, player) {
                  return SizedBox(
                    width:
                        isFullScreen ? MediaQuery.of(context).size.width : null,
                    height: isFullScreen
                        ? MediaQuery.of(context).size.height
                        : null,
                    child: player,
                  );
                })
            // : const SafeArea(
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   )
            ,

            isFullScreen == true
                ? const SizedBox()
                : Expanded(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        isVideoInfoLoading == false
                            ? TileBar(
                                videoInfo: videoData!,
                              )
                            : const SliverToBoxAdapter(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 15.0,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: HorizontalVideos(
                              fun: getVideoInfo,
                              youtubePlayerController: _controller,
                              title: "Releted",
                              videos: reletedVideos),
                        ),
                        SliverToBoxAdapter(
                          child: HorizontalVideos(
                            fun: getVideoInfo,
                            youtubePlayerController: _controller,
                            title: "Trending",
                            videos: trandingVideos,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Most Views",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0,
                                          color: AppColor.white),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "See All",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13.0,
                                            color: AppColor.gold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        PopularGrid(
                          videos: mostviewsVideos,
                          fun: getVideoInfo,
                          youtubePlayerController: _controller,
                        ),
                      ],
                    ),
                  ),
            //<Widget>[]
          ],
        )); //CustonScrollView
    //Scaffold
  }
}

class TileBar extends StatelessWidget {
  const TileBar({
    Key? key,
    required this.videoInfo,
  }) : super(key: key);
  final YoutubeDataModel videoInfo;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      toolbarHeight: 30.0,
      expandedHeight: 42,
      //backgroundColor: AppColor.white,
      centerTitle: true,
      flexibleSpace: ListTile(
        contentPadding: const EdgeInsets.only(left: 6.0, right: 0.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: CachedNetworkImage(
            imageUrl: videoInfo.thumbnailUrl!,
            placeholder: (context, url) => const Center(
                child: Padding(
              padding: EdgeInsets.all(15.0),
              child: CircularProgressIndicator(
                color: AppColor.gold,
              ),
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              );
            },
          ),
        ),
        trailing: FloatingActionButton(
          mini: true,
          onPressed: () {},
          backgroundColor: AppColor.black,
          child: const Icon(
            Icons.favorite_outline,
            color: AppColor.gold,
            size: 24.0,
          ),
        ),
        title: Text(
          videoInfo.title ?? "Title Not Loaded",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  videoInfo.authorName ?? "Author Name no Loaded",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0,
                      color: AppColor.gold),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              const Icon(
                Icons.favorite,
                color: AppColor.gold,
                size: 16.0,
              ),
              Text(
                "10",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                    color: AppColor.gold),
              ),
              const SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: (() {}),
                child: Row(
                  children: [
                    const Icon(
                      Icons.share_outlined,
                      color: AppColor.gold,
                      size: 16.0,
                    ),
                    Text(
                      " Share",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          color: AppColor.gold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularGrid extends StatelessWidget {
  const PopularGrid({
    Key? key,
    this.videos,
    required this.youtubePlayerController,
    required this.fun,
  }) : super(key: key);
  final List<VideoEntity>? videos;
  final YoutubePlayerController youtubePlayerController;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          String id =
              YoutubePlayer.convertUrlToId(videos![index].videoLink).toString();

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CachedNetworkImage(
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
                        onTap: (() {
                          fun.call(videos![index].videoLink);
                          youtubePlayerController.load(id);
                        }),
                        child: Stack(
                          children: [
                            Center(
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
                                  size: 35,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.0),
                                width: double.infinity,
                                color: AppColor.black.withOpacity(0.4),
                                child: Text(
                                  "Play Now",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: AppColor.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
        },
        childCount: 20,
      ),
    );
  }
}

class HorizontalVideos extends StatelessWidget {
  const HorizontalVideos({
    Key? key,
    required this.title,
    required this.videos,
    required this.youtubePlayerController,
    required this.fun,
  }) : super(key: key);
  final String title;
  final List<VideoEntity> videos;
  final YoutubePlayerController youtubePlayerController;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      width: MediaQuery.of(context).size.width,
      height: 130.0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                    color: AppColor.white),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "See All",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                      color: AppColor.gold),
                ),
              )
            ],
          ),
          // const SizedBox(
          //   height: 4.0,
          // ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  String id =
                      YoutubePlayer.convertUrlToId(videos[index].videoLink)
                          .toString();
                  return Container(
                      width: 130.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      height: 80.0,
                      child: CachedNetworkImage(
                        imageUrl: 'https://img.youtube.com/vi/$id/0.jpg',
                        placeholder: (context, url) => const Center(
                            child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: CircularProgressIndicator(
                            color: AppColor.gold,
                          ),
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageBuilder: (context, imageProvider) {
                          return Ink.image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6.0),
                              onTap: (() {
                                //load videos
                                fun.call(videos[index].videoLink);
                                youtubePlayerController.load(id);
                              }),
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
                          );
                        },
                      ));
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
