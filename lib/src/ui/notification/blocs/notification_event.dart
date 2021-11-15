part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetNotificationEvent extends NotificationEvent {}

class RemoveNotificationEvent extends NotificationEvent {
  final int id;
  RemoveNotificationEvent({required this.id});
}

class ClearNotificationEvent extends NotificationEvent {}
