import 'package:cloudmate/src/services/firebase_messaging/handle_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class Application {
  /// [Production - Dev]
  static String version = '1.0.0';
  static String? baseUrl = '';
  static String? imageUrl = '';
  static String? socketUrl = '';
  static String? mode = '';

  Future<void> initialAppLication() async {
    try {
      await Firebase.initializeApp();
      await GetStorage.init();
      await dotenv.load(fileName: ".env");
      baseUrl = 'http://139.180.222.96:3000/';
      imageUrl = baseUrl! + 'api/up-load-file?id=';
      socketUrl = 'http://139.180.222.96:3000/';
      mode = dotenv.env['MODE'];
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
