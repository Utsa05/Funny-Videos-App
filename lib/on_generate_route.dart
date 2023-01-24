import 'package:flutter/material.dart';
import 'package:funny_zone_app/domain/entities/sener.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:funny_zone_app/presentation/pages/home/home.dart';
import 'package:funny_zone_app/presentation/pages/notification/notiification.dart';
import 'package:funny_zone_app/presentation/pages/search/search.dart';
import 'package:funny_zone_app/presentation/pages/splash/splash.dart';
import 'package:funny_zone_app/presentation/pages/view_video/view_video.dart';

class AppRoute {
  static Route<dynamic> ongenerateRoute(RouteSettings settings) {
    final arg = settings.arguments;

    switch (settings.name) {
      case AppString.initialroute:
        return _pageRoute(const SplashPage());
      case AppString.homeroute:
        return _pageRoute(const HomePage());
      case AppString.viewvideo:
        final argValue = arg as SenderEnity;
        return _pageRoute(ViewVideo(
          senderEnity: argValue,
        ));
      // case AppString.favoriteroute:
      //   return _pageRoute(const FavoritePage());
      case AppString.notificationRoute:
        return _pageRoute(const NotificationPage());
      case AppString.searchroute:
        var sender = arg as SenderEnity;
        return _pageRoute(SearchPage(
          sender: sender,
        ));
      default:
        return _pageRoute(const ErrorRoutePage());
    }
  }
}

MaterialPageRoute _pageRoute(Widget page) =>
    MaterialPageRoute(builder: (builder) => page);

class ErrorRoutePage extends StatelessWidget {
  const ErrorRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Error"),
      ),
    );
  }
}
