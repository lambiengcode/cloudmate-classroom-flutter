import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/remote/class_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:sizer/sizer.dart';
part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial());
  List<ClassModel> classes = [];
  int skip = 0;
  bool isOverClasses = false;

  @override
  Stream<ClassState> mapEventToState(ClassEvent event) async* {
    if (event is TransitionToClassScreen) {
      if (classes.isEmpty) {
        yield ClassInitial();
        await _getClasses();
      } else {
        yield GettingClasses(
          listClasses: classes,
          isOver: isOverClasses,
        );
      }
      yield GetClassesDone(
        listClasses: classes,
        isOver: isOverClasses,
      );
    }

    if (event is GetClasses) {
      if (classes.isEmpty) {
        yield ClassInitial();
      } else {
        yield GettingClasses(
          listClasses: classes,
          isOver: isOverClasses,
        );
      }
      await _getClasses();
      yield GetClassesDone(
        listClasses: classes,
        isOver: isOverClasses,
      );
    }

    if (event is CreateClass) {
      yield GettingClasses(
        listClasses: classes,
        isOver: isOverClasses,
      );
      UserModel? myProfile = AppBloc.authBloc.userModel;
      bool isSuccess = await _createClass(
        event.name,
        event.topic,
        event.intro,
        myProfile!,
      );
      AppNavigator.pop();
      yield GetClassesDone(
        listClasses: classes,
        isOver: isOverClasses,
      );

      if (isSuccess) {
        AppNavigator.pop();
        _showDialogResult(event.context);
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Tạo lớp học thất bại, hãy thử lại sau!',
        );
      }
    }

    if (event is EditClass) {
      yield GettingClasses(
        listClasses: classes,
        isOver: isOverClasses,
      );
      UserModel? myProfile = AppBloc.authBloc.userModel;
      bool isSuccess = await _editClass(
        event.id,
        event.name,
        event.topic,
        event.intro,
        myProfile!,
      );
      AppNavigator.pop();
      yield GetClassesDone(
        listClasses: classes,
        isOver: isOverClasses,
      );

      if (isSuccess) {
        AppNavigator.pop();
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Bạn đã chỉnh sửa lớp học thành công',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Chỉnh lớp học thất bại, hãy thử lại sau!',
        );
      }
    }
  }

  Future<bool> _createClass(
    String name,
    String topic,
    String intro,
    UserModel myProfile,
  ) async {
    ClassModel? newClass = await ClassRepository().createClass(
      name: name,
      topic: topic,
      intro: intro,
      myProfile: myProfile,
    );

    if (newClass != null) {
      classes.insert(0, newClass);
    }

    return newClass != null;
  }

  Future<bool> _editClass(
    String id,
    String name,
    String topic,
    String intro,
    UserModel myProfile,
  ) async {
    ClassModel? newClass = await ClassRepository().editClass(
      id: id,
      name: name,
      topic: topic,
      intro: intro,
      myProfile: myProfile,
    );

    if (newClass != null) {
      int index = classes.indexWhere((item) => item.id == id);
      if (index != 1) {
        classes[index] = newClass;
      }
    }

    return newClass != null;
  }

  Future<void> _getClasses() async {
    List<ClassModel> listResult = await ClassRepository().getListClasses(
      skip: skip,
    );
    if (listResult.isNotEmpty) {
      classes.addAll(listResult);
      skip += listResult.length;
    } else {
      isOverClasses = true;
    }
  }

  void _showDialogResult(
    context, {
    String title = 'Thành công',
    String subTitle = 'Chúc mừng bạn đã tạo lớp học thành công',
  }) {
    dialogAnimationWrapper(
      dismissible: false,
      context: context,
      child: Container(
        width: 300.sp,
        height: 155.sp,
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 15.sp, vertical: 7.5.sp),
              child: Text(
                subTitle,
                style:
                    TextStyle(fontWeight: FontWeight.w400, fontSize: 11.5.sp),
              ),
            ),
            SizedBox(height: 8.sp),
            Divider(),
            GestureDetector(
              onTap: () {
                AppNavigator.pop();
              },
              child: Container(
                color: Colors.transparent,
                width: 300.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.sp),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: colorPrimary,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
