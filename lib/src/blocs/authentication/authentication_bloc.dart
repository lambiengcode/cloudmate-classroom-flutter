import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/blocs/post_home/post_home_bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/upload_response_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:cloudmate/src/resources/remote/authentication_repository.dart';
import 'package:cloudmate/src/resources/remote/upload_repository.dart';
import 'package:cloudmate/src/resources/remote/user_repository.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/common/widgets/get_snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialAuthenticationState());
  UserModel? userModel;

  final application = Application();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      bool isLogined = await _onAuthCheck();
      if (isLogined) {
        yield AuthenticationSuccess();
      } else {
        yield AuthenticationFail();
      }
    }

    if (event is OnClear) {
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }

    if (event is LoginEvent) {
      bool isSuccess = await _handleLogin(event);
      AppNavigator.pop();
      if (isSuccess) {
        yield AuthenticationSuccess(
          userModel: userModel,
        );
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Đăng nhập thất bại!',
          subTitle: 'Sai Email hoặc mật khẩu, hãy thử lại!',
        );
        getSnackBar.show();
        yield AuthenticationFail();
      }
    }

    if (event is RegisterEvent) {
      bool isSuccess = await _handleRegister(event);
      AppNavigator.pop();
      if (isSuccess) {
        yield AuthenticationSuccess(
          userModel: userModel,
        );
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Đăng kí thất bại!',
          subTitle: 'Email đã được đăng kí, hãy thử lại!',
        );
        getSnackBar.show();
        yield AuthenticationFail();
      }
    }

    if (event is LogOutEvent) {
      bool isSuccess = await _handleLogOut();
      if (isSuccess) {
        yield AuthenticationFail();
      }
    }

    if (event is GetInfoUser) {
      await _getUserInfo();
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }

    if (event is UpdateInfoUser) {
      await _updateUser(
        firstName: event.firstName,
        lastName: event.lastName,
        intro: event.intro,
        phone: event.phone,
      );
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }

    if (event is UpdateAvatarUser) {
      await _updateAvatar(avatar: event.avatar);
      yield AuthenticationSuccess(
        userModel: userModel,
      );
    }

    if (event is DeleteAccount) {
      await _deleteAccount();
      yield AuthenticationFail();
    }
  }

  Future<bool> _onAuthCheck() async {
    UserModel? userLocal = UserLocal().getUser();
    if (userLocal != null) {
      userModel = userLocal;
    }
    return UserLocal().getAccessToken() != '';
  }

  Future<bool> _handleLogin(LoginEvent event) async {
    String? token = await AuthenticationRepository().login(
      event.username,
      event.password,
    );

    return token != null;
  }

  Future<bool> _handleRegister(RegisterEvent event) async {
    bool isSuccess = await AuthenticationRepository().register(
      fistName: event.firstName,
      lastName: event.lastName,
      username: event.username,
      password: event.password,
    );

    return isSuccess;
  }

  Future<bool> _handleLogOut() async {
    AppBloc.classBloc.add(ClearClass());
    AppBloc.postHomeBloc.add(CleanPostHomeEvent());
    await FirebaseMessaging.instance.deleteToken();
    await AuthenticationRepository().logOut();
    return true;
  }

  Future<void> _getUserInfo() async {
    UserModel? user = await UserRepository().getInfoUser();
    if (user == null) {
      AppBloc.authBloc.add(LogOutEvent());
    } else {
      userModel = user;
      UserLocal().saveUser(user);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('_id', isEqualTo: user.id)
          .get();

      if (snapshot.docs.isEmpty) {
        FirebaseFirestore.instance.collection('users').add(user.toMap());
      } else {
        snapshot.docs.first.reference.update(user.toMap());
      }
    }
  }

  Future<void> _updateUser({
    required String firstName,
    required String lastName,
    required String intro,
    required String phone,
  }) async {
    UserModel? user = await UserRepository().updateUser(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      intro: intro,
    );

    if (userModel != null && user != null) {
      userModel!.firstName = user.firstName;
      userModel!.lastName = user.lastName;
      userModel!.phone = user.phone;
      userModel!.intro = user.intro;
      userModel!.displayName = user.displayName;
    }

    AppNavigator.popUntil(AppRoutes.ROOT);
  }

  Future<void> _updateAvatar({
    required File avatar,
  }) async {
    UploadResponseModel? response = await UploadRepository().uploadSingleFile(file: avatar);

    if (response != null) {
      UserModel? user = await UserRepository().updateAvatar(
        avatar: response.image,
        blurHash: response.blurHash,
      );
      if (user != null) {
        userModel = user;
      }
    }
    AppNavigator.popUntil(AppRoutes.ROOT);
  }

  Future<void> _deleteAccount() async {
    await UserRepository().deleteAccount();
    AppNavigator.popUntil(AppRoutes.ROOT);
    _handleLogOut();
  }
}
