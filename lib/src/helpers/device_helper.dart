import 'dart:io';

import 'package:cloudmate/src/models/device_model.dart';
import 'package:cloudmate/src/services/firebase_messaging/handle_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

Future<DeviceModel> getDeviceDetails() async {
  late String deviceName;
  // late String deviceVersion;
  late String identifier;
  late String appVersion;
  final String? fcmToken = await getFirebaseMessagingToken();
  print(fcmToken);
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      // deviceVersion = build.version.toString();
      identifier = build.androidId; //UUID for Android
      appVersion = "1.0.0";
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name;
      // deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //UUID for iOS
      appVersion = "1.0.0";
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
  return DeviceModel(
    appVersion: appVersion,
    deviceModel: deviceName,
    deviceUUid: identifier,
    fcmToken: fcmToken!,
  );
}
