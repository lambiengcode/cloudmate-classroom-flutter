import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/ui/common/widgets/get_snack_bar.dart';
import 'package:csv/csv.dart';
import 'package:cloudmate/src/models/user.dart';

Future<void> exportResultToExcel(List<UserModel> users) async {
    List<List<dynamic>> afterMapRevenue = [
      [
        'Họ tên',
        'Phone',
        'Điểm kiểm tra',
      ],
    ];
    users.forEach((e) {
      var values = [
        e.displayName,
        e.phone,
        e.score,
      ];
      var expectValues = [];
      for (int i = 0; i < users.length; i++) {
        expectValues.add(values[i]);
      }
      afterMapRevenue.add(expectValues);
    });
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final res = const ListToCsvConverter().convert(afterMapRevenue);
    ;
    late Directory downloadsDirectory;
    try {
      downloadsDirectory = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
    }
    String time = DateFormat('yyyy/MM/dd-HHmmss').format(DateTime.now());
    final pathOfTheFileToWrite = downloadsDirectory.path + "/RESULT-$time.csv";
    File file = File(pathOfTheFileToWrite);
    await file.writeAsString(res);
    GetSnackBar getSnackBar = GetSnackBar(
      title: 'Xuất excel thành công!',
      subTitle: 'Hãy kiểm tra file trong thư mục Downloads của điện thoại.',
    );
    getSnackBar.show();
  }
