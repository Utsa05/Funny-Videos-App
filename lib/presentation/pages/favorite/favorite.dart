import 'package:flutter/material.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/widgets/video_grid.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Favorite ",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                  color: AppColor.white),
            ),
            const Icon(Icons.favorite_outline),
            const SizedBox(
              width: 40.0,
            )
          ],
        ),
        //backgroundColor: AppColor.white.withOpacity(0.1),
      ),
      body: const VideoGrid(
        isToFavorite: true,
        videos: [],
        allvideos: [],
      ),
    );
  }
}
