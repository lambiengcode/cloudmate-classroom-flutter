import 'dart:convert';
import 'dart:io';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloudmate/src/ui/common/widgets/get_snack_bar.dart';
import 'package:csv/csv.dart';
import 'package:cloudmate/src/models/user.dart';

Future<void> exportResultToExcel(List<UserModel> users, int totalScore) async {
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
      '${e.score}/$totalScore',
    ];

    afterMapRevenue.add(values);
  });
  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  }
  // final res = const ListToCsvConverter().convert(afterMapRevenue);

  // late Directory downloadsDirectory;
  // try {
  //   downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  // } on PlatformException {
  //   print('Could not get the downloads directory');
  // }
  // String time = DateFormat('yyyyMMdd-HHmmss').format(DateTime.now());
  // final pathOfTheFileToWrite = downloadsDirectory.path + "/RESULT-$time.csv";
  // File file = File(pathOfTheFileToWrite);
  // await file.writeAsString(res);
  GetSnackBar getSnackBar = GetSnackBar(
    title: 'Xuất excel thành công!',
    subTitle: 'Hãy kiểm tra file trong thư mục Downloads của điện thoại.',
  );
  getSnackBar.show();
}

Future<List<QuestionModel>> pickFileExcel() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;

      final input = new File(file.path!).openRead();
      final fields =
          await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();

      List<QuestionModel> questions = [];

      fields.asMap().forEach((index, item) {
        if (index > 0) {
          questions.add(QuestionModel(
            id: index.toString(),
            question: item[0],
            duration: int.parse(item[1].toString()),
            score: int.parse(item[2].toString()),
            answers: item[3].toString().split(','),
            corrects: item[4].toString().split(',').map((e) => int.parse(e)).toList(),
            examId: '',
          ));
        }
      });

      return questions;
    }

    return [];
  } catch (err) {
    print(err);
    return [];
  }
}
