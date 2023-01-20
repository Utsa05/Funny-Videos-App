import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:funny_zone_app/domain/entities/appinfo.dart';
import 'package:funny_zone_app/domain/usecases/get_appinfo_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'appinfo_state.dart';

class AppinfoCubit extends Cubit<AppinfoState> {
  final GetAppInfoUsecase getAppInfoUsecase;
  AppinfoCubit({required this.getAppInfoUsecase}) : super(AppinfoInitial());

  Future<void> getAppInfo() async {
    // ignore: avoid_print
    print('appinfocall');
    emit(AppinfoLoading());

    try {
      final appinfo = await getAppInfoUsecase.call();

      emit(AppinfoLoaded(appInfoModel: appinfo));
    } on SocketException {
      emit(AppinfoNoInternet());
    } catch (e) {
      emit(AppinfoLoading());
    }
  }
}
