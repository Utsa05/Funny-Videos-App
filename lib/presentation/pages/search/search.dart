import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/widgets/video_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
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
            onChanged: (String value) {},
            onSubmitted: (String value) {},
          )
          //backgroundColor: AppColor.white.withOpacity(0.1),
          ),
      body: const VideoGrid(
        videos: [],
        allvideos: [],
      ),
    );
  }
}
