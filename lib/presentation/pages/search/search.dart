import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:funny_zone_app/domain/entities/video_entity.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/widgets/video_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.sender}) : super(key: key);
  final SenderEnity sender;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<VideoEntity> search = [];
  @override
  void initState() {
    search = widget.sender.videos;
    search.shuffle(Random());
    super.initState();
  }

  List<VideoEntity> getCategorybyVideo(String value) {
    List<VideoEntity> list = [];
    for (var video in widget.sender.videos) {
      if (video.category
          .toLowerCase()
          .toString()
          .contains(value.toLowerCase())) {
        list.add(video);
      }
    }
    return list;
  }

  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: CupertinoSearchTextField(
            itemColor: AppColor.gold,
            style: const TextStyle(color: AppColor.white),
            controller: _searchcontroller,
            onChanged: (String value) {
              if (value.isNotEmpty) {
                search = getCategorybyVideo(value);
                //search.shuffle(Random());
              } else {
                search = widget.sender.videos;
              }
              setState(() {});
            },
            onSubmitted: (String value) {},
          )
          //backgroundColor: AppColor.white.withOpacity(0.1),
          ),
      body: VideoGrid(
        info: widget.sender.info,
        videos: search,
        allvideos: search,
      ),
    );
  }
}
