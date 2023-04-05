import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/assignment_firestore_model.dart';
import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/services/firebase_storage/upload_file.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class SubmitDeadlineScreen extends StatefulWidget {
  final RoadMapContentModel roadMapContentModel;
  const SubmitDeadlineScreen({required this.roadMapContentModel});
  @override
  State<StatefulWidget> createState() => _SubmitDeadlineScreenState();
}

class _SubmitDeadlineScreenState extends State<SubmitDeadlineScreen> {
  FilePickerResult? filePicker;

  Future<void> pickFileExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.roadMapContentModel.fileExtensions,
      );

      setState(() {
        filePicker = result;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.roadMapContentModel.fileExtensions);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.sp),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26.sp),
            Container(
              child: Text(
                '\t${widget.roadMapContentModel.name}',
                style: TextStyle(
                  fontFamily: FontFamily.lato,
                  fontSize: 12.75.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 16.sp),
            GestureDetector(
              onTap: () async {},
              child: Container(
                height: 48.sp,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: AppDecoration.buttonActionBorderActive(context, 8.sp).decoration,
                child: Row(
                  children: [
                    SizedBox(width: 6.sp),
                    Expanded(
                      child: Text(
                        filePicker == null ? 'Chọn file' : filePicker!.files.first.name,
                        style: TextStyle(
                          fontFamily: FontFamily.lato,
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    GestureDetector(
                      onTap: () async {
                        showDialogLoading(context);
                        await pickFileExcel();
                        AppNavigator.pop();
                      },
                      child: Container(
                        height: 32.sp,
                        width: 32.sp,
                        decoration: BoxDecoration(
                          color: colorHigh,
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          PhosphorIcons.folderNotchOpenFill,
                          size: 15.sp,
                          color: mC,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            GestureDetector(
              onTap: () async {
                if (filePicker != null && filePicker!.files.isNotEmpty) {
                  showDialogLoading(context);
                  String? urlToFile =
                      await StorageService().uploadFileToStorage(filePicker!.files.first.path!);
                  await FirebaseFirestore.instance
                      .collection('assignments')
                      .add(AssignmentFirestoreModel(
                        createdBy: AppBloc.authBloc.userModel?.id ?? '',
                        fileName: filePicker!.files.first.name,
                        createdAt: Timestamp.fromDate(DateTime.now()),
                        urlToFile: urlToFile,
                        roadMapContentId: widget.roadMapContentModel.id,
                      ).toMap());

                  AppNavigator.pop();
                  AppNavigator.pop();
                }
              },
              child: Container(
                height: 38.sp,
                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: filePicker != null ? colorPrimary : colorDarkGrey,
                ),
                child: Center(
                  child: Text(
                    'Nộp bài',
                    style: TextStyle(
                      color: mC,
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.sp),
          ],
        ),
      ),
    );
  }
}
