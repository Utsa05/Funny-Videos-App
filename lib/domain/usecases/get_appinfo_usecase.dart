import 'package:funny_zone_app/domain/entities/appinfo.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';

class GetAppInfoUsecase {
  final FirebaseRepository repository;

  GetAppInfoUsecase(this.repository);

  Future<AppInfoEntity> call() async {
    return await repository.getAppInfo();
  }
}
