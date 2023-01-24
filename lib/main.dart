// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:funny_zone_app/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  runApp(const VideoApp());
}
