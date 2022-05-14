import 'package:cloudmate/src/models/user.dart';
import 'package:get_storage/get_storage.dart';

class UserLocal {
  final _getStorage = GetStorage();
  final storageKey = 'token';
  final storageKeyUser = 'userLocal';

  String getAccessToken() {
    return _getStorage.read(storageKey) ?? '';
  }

  UserModel? getUser() {
    var rawData = _getStorage.read(storageKeyUser);
    if (rawData != null) {
      return UserModel.fromJson(rawData);
    }
    return null;
  }

  void saveAccessToken(String token) async {
    _getStorage.write(storageKey, token);
  }

  void saveUser(UserModel user) async {
    _getStorage.write(storageKeyUser, user.toJson());
  }

  void clearAccessToken() async {
    _getStorage.remove(storageKey);
  }
}
