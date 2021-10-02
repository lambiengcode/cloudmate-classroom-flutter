import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/resources/remote/class_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  ClassBloc() : super(ClassInitial());
  List<ClassModel> classes = [];
  int skip = 0;
  int limit = 10;
  bool isOverClasses = false;

  @override
  Stream<ClassState> mapEventToState(ClassEvent event) async* {
    if (event is GetClasses) {
      if (classes.isEmpty) {
        yield ClassInitial();
      } else {
        yield GettingClasses(
          listClasses: classes,
        );
      }
      await Future.delayed(Duration(seconds: 2), () async {});
      yield GetClassesDone(
        listClasses: classes,
      );
    }

    if (event is CreateClass) {
      yield GettingClasses(
        listClasses: classes,
      );
      bool isSuccess = await _createClass(event.name, event.topic, event.intro);
      AppNavigator.pop();
      yield GetClassesDone(
        listClasses: classes,
      );

      if (isSuccess) {
        AppNavigator.pop();
        _showDialogResult(event.context);
      } else {
        _showDialogResult(
          event.context,
          title: 'Tạo lớp học thất bại, hãy thử lại sau!',
        );
      }
    }
  }

  Future<bool> _createClass(String name, String topic, String intro) async {
    ClassModel? newClass = await ClassRepository().createClass(
      name: name,
      topic: topic,
      intro: intro,
    );

    if (newClass != null) {
      classes.insert(0, newClass);
    }

    return newClass != null;
  }

  void _showDialogResult(
    context, {
    String title = 'Chúc mừng bạn đã tạo lớp học thành công',
  }) {}
}
