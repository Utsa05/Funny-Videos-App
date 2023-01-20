// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:funny_zone_app/data/datasource/firebase_remote_datasource.dart';
import 'package:funny_zone_app/data/repositories/firebase_repository_impl.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';
import 'package:funny_zone_app/domain/usecases/add_like_usecase.dart';
import 'package:funny_zone_app/domain/usecases/get_appinfo_usecase.dart';
import 'package:funny_zone_app/domain/usecases/get_notification_usecase.dart';
import 'package:funny_zone_app/domain/usecases/get_videos_usecase.dart';
import 'package:funny_zone_app/presentation/cubits/appinfo/appinfo_cubit.dart';
import 'package:funny_zone_app/presentation/cubits/notification/notification_cubit.dart';
import 'package:funny_zone_app/presentation/cubits/video/video_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //cubit
  sl.registerFactory<AppinfoCubit>(
      () => AppinfoCubit(getAppInfoUsecase: sl.call()));
  sl.registerFactory<VideoCubit>(() => VideoCubit(videosUsecase: sl.call()));
  sl.registerFactory<NotificationCubit>(
      () => NotificationCubit(getNotificationUsecase: sl.call()));

  //usecase
  sl.registerLazySingleton<GetAppInfoUsecase>(
      () => GetAppInfoUsecase(sl.call()));
  sl.registerLazySingleton<GetVideosUsecase>(() => GetVideosUsecase(sl.call()));
  sl.registerLazySingleton<GetNotificationUsecase>(
      () => GetNotificationUsecase(sl.call()));
  sl.registerLazySingleton<AddLikeUsecase>(() => AddLikeUsecase(sl.call()));

  //repositories

  sl.registerLazySingleton<FirebaseRemoteDatasource>(
      () => FirebaseRemoteDatasourceImpl(firebaseFiresore: sl.call()));
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(datasource: sl.call()));

  //externernal
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
  print('init successfully');
}
