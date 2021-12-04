import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/user.dart';

class MembersHelper {
    List<UserModel> getMembers(List<UserModel> users) {
      String userId = AppBloc.authBloc.userModel!.id;
      return users.where((user) => user.id != userId && user.role == 0).toList();
    }
}
