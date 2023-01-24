// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:funny_zone_app/on_generate_route.dart';
import 'package:funny_zone_app/presentation/constants/color.dart';
import 'package:funny_zone_app/presentation/constants/string.dart';
import 'package:funny_zone_app/presentation/cubits/releted/releted_cubit.dart';
import 'package:funny_zone_app/presentation/cubits/video/video_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di.dart' as di;
import 'presentation/cubits/appinfo/appinfo_cubit.dart';
import 'presentation/cubits/notification/notification_cubit.dart';

class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  State<VideoApp> createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  void initState() {
    slinit();
    super.initState();
  }

  slinit() async {
    await di.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<VideoCubit>()..getVideos(),
        ),
        BlocProvider(
          create: (context) => di.sl<AppinfoCubit>()..getAppInfo(),
        ),
        BlocProvider(
          create: (context) => di.sl<NotificationCubit>()..getNotification(),
        ),
        BlocProvider(
          create: (context) => ReletedCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColor.black,
            textTheme: TextTheme(
                bodyText2:
                    GoogleFonts.openSans(color: AppColor.white, fontSize: 14.0),
                headline6:
                    GoogleFonts.openSans(color: AppColor.white, fontSize: 28.0),
                headline1: GoogleFonts.openSans(
                    color: AppColor.white,
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold)),
            appBarTheme: const AppBarTheme(
                backgroundColor: AppColor.black,
                iconTheme: IconThemeData(color: AppColor.white))),
        title: AppString.appname,
        debugShowCheckedModeBanner: false,
        initialRoute: AppString.initialroute,
        onGenerateRoute: AppRoute.ongenerateRoute,
      ),
    );
  }
}
