import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class PathHelper {
  static Future<void> deleteCacheImageDir(String path) async {
    final cacheDir = Directory(path);
    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<Directory> get tempDir async => await path_provider.getTemporaryDirectory();

  static Future<Directory> get appDir async =>
      await path_provider.getApplicationDocumentsDirectory();

  static Future<Directory?> get downloadsDir async {
    Directory downloadsDirectory;
    try {
      if (Platform.isIOS) {
        downloadsDirectory = await path_provider.getApplicationDocumentsDirectory();
      } else {
        downloadsDirectory = await path_provider.getApplicationSupportDirectory();
      }

      return downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
      return null;
    }
  }
}
