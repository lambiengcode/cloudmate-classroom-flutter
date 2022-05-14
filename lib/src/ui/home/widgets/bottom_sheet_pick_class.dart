import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/post_home/post_home_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetPickClass extends StatefulWidget {
  final String content;
  final Function handleFinished;
  const BottomSheetPickClass({required this.content, required this.handleFinished});
  @override
  State<StatefulWidget> createState() => _BottomSheetPickClassState();
}

class _BottomSheetPickClassState extends State<BottomSheetPickClass> {
  List<String> classesPicked = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.sp),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.only(top: 30.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              _buildTitle('Đăng bài viết vào lớp:'),
              SizedBox(height: 16.sp),
              BlocBuilder<ClassBloc, ClassState>(
                builder: (context, state) {
                  List<ClassModel> classes = (state.props[0] as List).cast();
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 10,
                      children: classes.map((classModel) {
                        int indexOfShare =
                            classesPicked.indexWhere((element) => element == classModel.id);
                        bool isPicked = indexOfShare != -1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isPicked) {
                                classesPicked.removeAt(indexOfShare);
                              } else {
                                classesPicked.add(classModel.id);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6.25.sp,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                30.sp,
                              ),
                              color: isPicked ? colorPrimary : Colors.grey,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 16.sp),
                                Text(
                                  classModel.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 16.sp),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.sp),
              GestureDetector(
                onTap: () {
                  if (classesPicked.isNotEmpty) {
                    AppNavigator.pop();
                    widget.handleFinished();
                    showDialogLoading(context);
                    AppBloc.postHomeBloc.add(
                      CreatePostHomeEvent(
                        classChooses: classesPicked,
                        content: widget.content,
                      ),
                    );
                  }
                },
                child: Container(
                  height: 38.sp,
                  margin: EdgeInsets.symmetric(horizontal: 40.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: classesPicked.isEmpty ? colorDarkGrey : colorPrimary,
                  ),
                  child: Center(
                    child: Text(
                      'Đăng bài viết',
                      style: TextStyle(
                        color: mC,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.0),
            ],
          ),
        ],
      ),
    );
  }

  _buildTitle(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 16.sp),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.lato,
                color: colorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
