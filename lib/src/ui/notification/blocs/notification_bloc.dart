import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/notification_model.dart';
import 'package:cloudmate/src/resources/remote/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());

  List<NotificationModel> notifications = [];
  bool isNotificationOver = false;

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is GetNotificationEvent) {
      if (notifications.isEmpty) {
        yield NotificationInitial();
      } else {
        yield GettingNotification(notificationList: notifications);
      }

      await _getNotification();

      yield GetDoneNotification(notificationList: notifications);
    }
  }

  // MARK: - Private methods
  Future<void> _getNotification() async {
    List<NotificationModel> notificationList = await NotificationRepository().getNotifications();

    if (notificationList.isEmpty) {
      isNotificationOver = true;
    } else {
      notifications.addAll(notificationList);
    }
  }
}
