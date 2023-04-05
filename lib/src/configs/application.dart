import 'package:cloudmate/src/services/firebase_messaging/handle_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Application {
  /// [Production - Dev]
  static String version = '1.0.0';
  static String baseUrl = '';
  static String imageUrl = '';
  static String socketUrl = '';
  static String mode = '';
  static bool isProductionMode = true;

  Future<void> initialAppLication() async {
    try {
      await GetStorage.init();
      baseUrl = 'https://services.streamos.tk/';
      imageUrl = baseUrl + 'api/up-load-file?id=';
      socketUrl = 'https://services.streamos.tk/';
      mode = 'PRODUCTION'; 
      requestPermission();
      handleReceiveNotification();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
