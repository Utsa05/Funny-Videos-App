part of 'appinfo_cubit.dart';

@immutable
abstract class AppinfoState {}

class AppinfoInitial extends AppinfoState {}

class AppinfoLoading extends AppinfoState {}

class Appinfofailure extends AppinfoState {}

class AppinfoNoInternet extends AppinfoState {}

class AppinfoLoaded extends AppinfoState {
  final AppInfoEntity appInfoModel;

  AppinfoLoaded({required this.appInfoModel});
}
