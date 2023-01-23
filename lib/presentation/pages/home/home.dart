// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:funny_zone_app/presentation/cubits/video/video_cubit.dart';
import 'package:funny_zone_app/presentation/pages/home/utils/app_drawer.dart';
import 'package:funny_zone_app/presentation/widgets/video_grid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoaded) {
            return Scaffold(
              key: _scaffoldKey,
              drawer: const AppDrawer(),
              appBar: homeAppbar(context),
              body: AllViews(videos: state.videos),
            );
          } else if (state is VideoNoInternet) {
            return const Center(
              child: Text("No Internet"),
            );
          } else if (state is VideoFailure) {
            return const Center(
              child: Text("Failur"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  AppBar homeAppbar(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      iconTheme: const IconThemeData(color: AppColor.gold, size: 0.0),
      centerTitle: false,
      title: Container(
          margin: const EdgeInsets.only(
            top: 5.0,
          ),
          child: Image.asset(
            'assets/logo/Small logo home-01.png',
            width: 160.0,
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 3.0,
            bottom: 4.0,
          ),
          child: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pushNamed(context, AppString.searchroute);
            },
            icon: const Icon(
              Icons.search_outlined,
              size: 25.0,
              color: AppColor.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 3.0,
            bottom: 4.0,
          ),
          child: IconButton(
            splashRadius: 20,
            onPressed: () {
              Navigator.pushNamed(context, AppString.favoriteroute);
            },
            icon: const Icon(
              Icons.favorite_outline,
              size: 25.0,
              color: AppColor.white,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              top: 3.0,
              bottom: 4.0,
            ),
            child: IconButton(
              splashRadius: 20,
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu_outlined,
                size: 25.0,
                color: AppColor.white,
              ),
            ))
      ],
      bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(10.0),
          tabs: const [
            Tab(
              text: 'For You',
            ),
            Tab(
              text: 'Recent',
            ),
            Tab(
              text: 'Most View',
            ),
            Tab(
              text: 'Trending',
            ),
            Tab(
              text: 'Popular',
            ),
            Tab(
              text: 'Hot',
            ),
          ]),
    );
  }
}

class AllViews extends StatelessWidget {
  const AllViews({
    super.key,
    required this.videos,
  });
  final List<VideoEntity> videos;
  @override
  Widget build(BuildContext context) {
    final random = Random();

    List<VideoEntity> getCategorybyVideo(String category) {
      List<VideoEntity> list = [];
      for (var video in videos) {
        if (video.category.toLowerCase().toString() == category.toLowerCase()) {
          list.add(video);
        }
      }
      return list;
    }

    List<VideoEntity> recentVideos = getCategorybyVideo("Recent");
    List<VideoEntity> popularVideos = getCategorybyVideo("Popular");
    List<VideoEntity> hotVideos = getCategorybyVideo("Hot");
    List<VideoEntity> mostviewsVideos = getCategorybyVideo("Most viewed");
    List<VideoEntity> trandingVideos = getCategorybyVideo("Tranding");
    recentVideos.shuffle(random);
    popularVideos.shuffle(random);
    mostviewsVideos.shuffle(random);
    mostviewsVideos.shuffle(random);
    trandingVideos.shuffle(random);
    return TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
      CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
            child: TopVideos(videos: mostviewsVideos),
          )),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var videoItem = videos[random.nextInt(videos.length)];
                String? id = YoutubePlayer.convertUrlToId(
                    videoItem.videoLink.toString());

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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Ink.image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6.0),
                              onTap: (() {
                                Navigator.pushNamed(
                                    context, AppString.viewvideo,
                                    arguments: SenderEnity(
                                        videos: videos,
                                        url: videoItem.videoLink,
                                        category: videoItem.category));
                              }),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColor.black.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7.0),
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
              childCount: videos.length,
            ),
          )
        ],
      ),
      VideoGrid(
        videos: recentVideos,
        allvideos: videos,
      ),
      VideoGrid(videos: mostviewsVideos, allvideos: videos),
      VideoGrid(videos: trandingVideos, allvideos: videos),
      VideoGrid(videos: popularVideos, allvideos: videos),
      VideoGrid(videos: hotVideos, allvideos: videos),
    ]);
  }
}

class TopVideos extends StatelessWidget {
  const TopVideos({
    Key? key,
    required this.videos,
  }) : super(key: key);
  final List<VideoEntity> videos;
  @override
  Widget build(BuildContext context) {
    final random = Random();
    // Future<VideoData?> results;

    // void getData()  {
    //   results = Extractor.getDirectLink(
    //       link: 'https://www.youtube.com/watch?v=Ne7y9_AbBsY');

    //   print(results.then((value) => value!.title));
    // }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(10, (index) {
          var item = videos[random.nextInt(videos.length)];
          String id = YoutubePlayer.convertUrlToId(item.videoLink).toString();

          return Container(
              decoration: BoxDecoration(
                //color: AppColor.grey,
                borderRadius: BorderRadius.circular(6.0),
              ),
              width: 130.0,
              margin: const EdgeInsets.only(right: 10.0),
              height: 90.0,
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
                  return Ink.image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(6.0),
                      onTap: (() {
                        Navigator.pushNamed(context, AppString.viewvideo,
                            arguments: SenderEnity(
                                videos: videos,
                                url: item.videoLink,
                                category: item.category));
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
    );
  }
}
