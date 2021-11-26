import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/user.dart';

class RoleHelper {
  bool canShowOptionReport(List<UserModel> members, String createdBy) {
    String userId = AppBloc.authBloc.userModel!.id;
    List<String> memberIds = members.map((m) => m.id).toList();
    if (memberIds.contains(userId) && userId != createdBy) {
      return true;
    }
    return false;
  }

  bool canShowDrawerClass(List<UserModel> members, String createdBy) {
    String userId = AppBloc.authBloc.userModel!.id;
    List<String> memberIds = members.map((m) => m.id).toList();
    if (memberIds.contains(userId) || userId == createdBy) {
      return true;
    }
    return false;
  }
}
