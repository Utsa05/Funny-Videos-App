part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationFailure extends NotificationState {}

class NotificationNoInternet extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notificationList;

  NotificationLoaded({required this.notificationList});
}
