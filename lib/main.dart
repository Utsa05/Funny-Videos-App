// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:funny_zone_app/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const VideoApp());
}
