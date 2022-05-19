import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/upload_response_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/remote/class_repository.dart';
import 'package:cloudmate/src/resources/remote/upload_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial());
  List<ClassModel> classes = [];
  List<ClassModel> recommendClasses = [];
  int skip = 0;
  int skipRecommend = 0;
  bool isOverClasses = false;
  bool isOverRecommend = false;

  @override
  Stream<ClassState> mapEventToState(ClassEvent event) async* {
    if (event is TransitionToClassScreen) {
      yield ClassInitial();
      _resetRecommendClass();
      if (classes.isEmpty) {
        await _getClasses();
      }
      await _getRecommedClasses();
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
    }

    if (event is GetClasses) {
      if (classes.isEmpty) {
        yield ClassInitial();
      } else {
        yield GettingClasses(
          listClasses: classes,
          listRecommend: recommendClasses,
          isOver: isOverClasses,
        );
      }
      await _getClasses();
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
    }

    if (event is CreateClass) {
      yield GettingClasses(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
      UserModel? myProfile = AppBloc.authBloc.userModel;
      bool isSuccess = await _createClass(
        event.name,
        event.topic,
        event.intro,
        myProfile!,
        event.price,
      );
      AppNavigator.pop();
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
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
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
      UserModel? myProfile = AppBloc.authBloc.userModel;
      bool isSuccess = await _editClass(
        event.id,
        event.name,
        event.topic,
        event.intro,
        myProfile!,
        event.setOfQuestionShare,
        event.price,
      );
      AppNavigator.pop();
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
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

    if (event is GetMemberClass) {
      await _getMembers(classId: event.classId);
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
    }

    if (event is LeaveClass) {
      bool isLeaveSuccess = await _leaveClass(classId: event.classId);
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
      if (isLeaveSuccess) {
        AppNavigator.popUntil(AppRoutes.ROOT);
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Rời khỏi lớp thất bại, hãy thử lại sau!',
        );
      }
    }

    if (event is JoinClass) {
      bool isJoinSuccess = await _joinClass(
        classId: event.classId,
        amount: event.amount,
        senderPhone: event.senderPhone,
      );
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
      if (isJoinSuccess) {
        _showDialogResult(
          event.context,
          title: 'Thành công',
          subTitle: 'Chúc mừng, bạn đã là học viên của lớp!',
        );
      } else {
        _showDialogResult(
          event.context,
          title: 'Thất bại',
          subTitle: 'Tham gia thất bại, hãy thử lại sau!',
        );
      }
    }

    if (event is UpdateImageClass) {
      UserModel? myProfile = AppBloc.authBloc.userModel;
      await _updateImageClass(
        id: event.id,
        image: event.image,
        myProfile: myProfile!,
      );

      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
    }

    if (event is ClearClass) {
      classes.clear();
      recommendClasses.clear();
      isOverClasses = false;
      isOverRecommend = false;
      skip = 0;
      skipRecommend = 0;
      yield GetClassesDone(
        listClasses: classes,
        listRecommend: recommendClasses,
        isOver: isOverClasses,
      );
    }
  }

  // MARK: - Event handler function

  Future<bool> _createClass(
    String name,
    String topic,
    String intro,
    UserModel myProfile,
    double price,
  ) async {
    ClassModel? newClass = await ClassRepository().createClass(
      name: name,
      topic: topic,
      intro: intro,
      myProfile: myProfile,
      price: price,
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
    List<String> setOfQuestionShare,
    double price,
  ) async {
    ClassModel? newClass = await ClassRepository().editClass(
      id: id,
      name: name,
      topic: topic,
      intro: intro,
      myProfile: myProfile,
      setOfQuestionShare: setOfQuestionShare,
      price: price,
    );

    if (newClass != null) {
      int index = classes.indexWhere((item) => item.id == id);
      if (index != -1) {
        classes[index] = newClass;
      }
    }

    return newClass != null;
  }

  Future<void> _updateImageClass({
    required String id,
    required File image,
    required UserModel myProfile,
  }) async {
    UploadResponseModel? response = await UploadRepository().uploadSingleFile(file: image);

    if (response != null) {
      ClassModel? newClass = await ClassRepository().editImageClass(
        id: id,
        myProfile: myProfile,
        image: response.image,
        blurHash: response.blurHash,
      );

      if (newClass != null) {
        int index = classes.indexWhere((item) => item.id == id);
        if (index != -1) {
          classes[index] = newClass;
        }
      }
    }
    AppNavigator.popUntil(AppRoutes.DETAILS_CLASS);
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

  Future<void> _getMembers({required String classId}) async {
    List<UserModel> listResult = await ClassRepository().getListMembers(classId: classId);
    if (listResult.isNotEmpty) {
      int index = classes.indexWhere((item) => item.id == classId);
      classes[index].members = listResult;
    }
  }

  Future<void> _getRecommedClasses() async {
    List<ClassModel> listResult = await ClassRepository().getListRecommendClasses(
      skip: skipRecommend,
    );
    if (listResult.isNotEmpty) {
      recommendClasses.addAll(listResult);
      skipRecommend += listResult.length;
    } else {
      isOverRecommend = true;
    }
  }

  Future<bool> _joinClass({
    required String classId,
    required String senderPhone,
    required double amount,
  }) async {
    bool isJoinSuccess = await ClassRepository().joinClass(
      classId: classId,
      senderPhone: senderPhone,
      amount: amount,
    );
    AppNavigator.pop();
    if (isJoinSuccess) {
      int index = recommendClasses.indexWhere((item) => item.id == classId);
      UserModel myProfile = AppBloc.authBloc.userModel!;
      if (index != -1) {
        classes.add(recommendClasses[index]);
        recommendClasses.removeAt(index);
        classes[classes.length - 1].members.add(myProfile);
      }
    }
    return isJoinSuccess;
  }

  Future<bool> _leaveClass({required String classId}) async {
    bool isLeaveSuccess = await ClassRepository().leaveClass(classId: classId);
    AppNavigator.pop();
    if (isLeaveSuccess) {
      int index = classes.indexWhere((item) => item.id == classId);
      if (index != -1) {
        recommendClasses.add(classes[index]);
        classes.removeAt(index);
      }
    }
    return isLeaveSuccess;
  }

  void _resetRecommendClass() {
    recommendClasses.clear();
    skipRecommend = 0;
    isOverRecommend = false;
  }

  void _showDialogResult(
    context, {
    String title = 'Thành công',
    String subTitle = 'Chúc mừng bạn đã tạo lớp học thành công',
  }) {
    dialogAnimationWrapper(
      dismissible: false,
      context: context,
      child: DialogNotice(
        title: title,
        subTitle: subTitle,
      ),
    );
  }
}
