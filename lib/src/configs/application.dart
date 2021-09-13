import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class Application {
  /// [Production - Dev]
  static String version = '1.0.0';
  static String? baseUrl = '';
  static String? socketUrl = '';
  static String? mode = '';

  Future<void> initialAppLication() async {
    try {
      await GetStorage.init();
      await dotenv.load(fileName: ".env");
      baseUrl = dotenv.env['BASE_URL'];
      socketUrl = dotenv.env['SOCKET_URL'];
      mode = dotenv.env['MODE'];
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
