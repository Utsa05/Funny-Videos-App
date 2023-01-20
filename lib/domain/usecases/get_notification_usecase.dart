import 'package:funny_zone_app/domain/entities/notification.dart';
import 'package:funny_zone_app/domain/repositories/firebase_repository.dart';

class GetNotificationUsecase {
  final FirebaseRepository repository;

  GetNotificationUsecase(this.repository);

  Stream<List<NotificationEntity>> call() {
    return repository.getNotifications();
  }
}
