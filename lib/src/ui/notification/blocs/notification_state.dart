part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {
  List<dynamic> get props => [];
}

class NotificationInitial extends NotificationState {}

class GettingNotification extends NotificationState {
  final List<NotificationModel> notificationList;
  GettingNotification({required this.notificationList});

  @override
  List get props => [notificationList];
}

class GetDoneNotification extends NotificationState {
  final List<NotificationModel> notificationList;
  GetDoneNotification({required this.notificationList});

  @override
  List get props => [notificationList];
}
