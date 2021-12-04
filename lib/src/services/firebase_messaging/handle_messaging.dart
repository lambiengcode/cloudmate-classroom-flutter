import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<String?> getFirebaseMessagingToken() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token = await _firebaseMessaging.getToken();
  return token;
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

handleReceiveNotification(context) async {
  await requestPermission();
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    handleTouchOnNotification(message);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    dialogAnimationWrapper(
      dismissible: false,
      context: context,
      child: DialogConfirm(
        title: '',
        subTitle: '',
        handleConfirm: () {
          handleTouchOnNotification(message);
        },
      ),
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('A new onMessageOpenedApp event was published!' + ' ${message.data.toString()}');

    handleTouchOnNotification(message);
  }).onError((error) => print('Error: $error [\'lambiengcode\']'));
}

handleTouchOnNotification(RemoteMessage? message) {}
