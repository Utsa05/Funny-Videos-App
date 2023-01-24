// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_import

import 'dart:math';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:youtube_video_info/youtube_video_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (widget.senderEnity.info.addstatus!.toLowerCase() == "on") {
      _createInterstitialAd(widget.senderEnity.info.interstitialad!);
    }
    super.initState();
  }

  bool isForinfinitytime = false;
  int numofitemClick = 0;
  InterstitialAd? _interstitialAd;

  getVideoInfo(String url) async {
    isVideoInfoLoading = true;
    videoData = await YoutubeData.getData(url);
    print("HI :");
    print(videoData!.authorName);
    print(videoData!.url);
    isVideoInfoLoading = false;

    setState(() {});
  }

  void _createInterstitialAd(String id) {
    InterstitialAd.load(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;

            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    _controller.reset();
    super.dispose();
  }

  // _controller.load(YoutubePlayer.convertUrlToId(
  //               "https://youtu.be/k6eyzRda9zU?list=RDMMcZZDrkPmvKc")
  //           .toString());
  bool isFullScreen = false;
  void counterFun() {
    if (numofitemClick <= 5) {
      numofitemClick++;
    } else {
      _showInterstitialAd();
      numofitemClick = 0;
    }
    print(numofitemClick);

    setState(() {});
  }

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
    List<VideoEntity> mostviewsVideos = [];
    switch (widget.senderEnity.category) {
      case 'Most viewed':
        mostviewsVideos = getCategorybyVideo("Hot");
        break;
      default:
        mostviewsVideos = getCategorybyVideo("Most viewed");
    }
    List<VideoEntity> trandingVideos = getCategorybyVideo("Tranding");
    reletedVideos.shuffle(Random());
    mostviewsVideos.shuffle(Random());
    trandingVideos.shuffle(Random());
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
                                  child: CircularProgressIndicator(
                                    color: AppColor.gold,
                                  ),
                                ),
                              ),
                        // SliverToBoxAdapter(
                        //   child: SizedBox(
                        //     height: 15.0,
                        //     child: MaterialButton(
                        //         color: AppColor.white,
                        //         onPressed: () {
                        //           reletedVideos = getCategorybyVideo("Hot");
                        //           setState(() {});
                        //         }),
                        //   ),
                        // ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              HorizontalVideos(
                                  counterFun: counterFun,
                                  fun: getVideoInfo,
                                  youtubePlayerController: _controller,
                                  title: "Releted",
                                  // reletedFun:reletedVideos(),
                                  horizontalVideos: reletedVideos,
                                  count: numofitemClick),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: HorizontalVideos(
                            counterFun: counterFun,
                            count: numofitemClick,
                            fun: getVideoInfo,
                            youtubePlayerController: _controller,
                            title: "Trending",
                            horizontalVideos: trandingVideos,
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
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppString.searchroute,
                                        arguments: mostviewsVideos);

                                    _controller.pause();
                                  },
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
                          counterFun: counterFun,
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
      toolbarHeight: 35.0,
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
        trailing: const SizedBox(
          width: 10.0,
        ),
        // trailing: FloatingActionButton(
        //   mini: true,
        //   onPressed: () {},
        //   backgroundColor: AppColor.black,
        //   child: const Icon(
        //     Icons.share_outlined,
        //     color: AppColor.gold,
        //     size: 24.0,
        //   ),
        // ),
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
                Icons.remove_red_eye_outlined,
                color: AppColor.gold,
                size: 16.0,
              ),
              const SizedBox(
                width: 3.0,
              ),
              Text(
                videoInfo.viewCount.toString(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                    color: AppColor.gold),
              ),
              const SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: (() {
                  Share.share(
                      'This video shared from Funny Video App\n${videoInfo.url}\navailale on Google Playstore',
                      subject: "Share Now");
                }),
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
    required this.counterFun,
  }) : super(key: key);
  final List<VideoEntity>? videos;
  final YoutubePlayerController youtubePlayerController;
  final Function fun;
  final Function counterFun;

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
                          counterFun.call();
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

class HorizontalVideos extends StatefulWidget {
  const HorizontalVideos({
    Key? key,
    required this.title,
    required this.horizontalVideos,
    required this.youtubePlayerController,
    required this.fun,
    this.reletedFun,
    required this.count,
    required this.counterFun,
  }) : super(key: key);
  final String title;
  final List<VideoEntity> horizontalVideos;
  final YoutubePlayerController youtubePlayerController;
  final Function fun;
  final Function? reletedFun;
  final Function counterFun;
  final int count;

  @override
  State<HorizontalVideos> createState() => _HorizontalVideosState();
}

class _HorizontalVideosState extends State<HorizontalVideos> {
  int mycount = 0;
  @override
  void initState() {
    mycount = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<VideoEntity> videos = widget.horizontalVideos;
    // List<VideoEntity> getCategorybyVideo(String category) {
    //   List<VideoEntity> list = [];
    //   for (var video in widget.horizontalVideos) {
    //     if (video.category.toLowerCase().toString() == category.toLowerCase()) {
    //       list.add(video);
    //     }
    //   }
    //   return list;
    // }

    // setVideos(String category) {
    //   videos = getCategorybyVideo(category);

    //   print(category);
    //   setState(() {});
    // }

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
                widget.title,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0,
                    color: AppColor.white),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 4.0,
          // ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(videos.length > 20 ? 20 : 10, (index) {
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
                                widget.fun.call(videos[index].videoLink);

                                widget.youtubePlayerController.load(id);
                                widget.counterFun.call();
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
