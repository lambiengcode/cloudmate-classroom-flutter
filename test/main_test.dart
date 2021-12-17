import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/resources/remote/authentication_repository.dart';
import 'package:cloudmate/src/resources/remote/class_repository.dart';
import 'package:cloudmate/src/resources/remote/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AuthenticationRepository? authRepository;
  UserRepository? userRepository;
  ClassRepository? classRepository;

  setUp(() async {
    authRepository = AuthenticationRepository();
    userRepository = UserRepository();
    classRepository = ClassRepository();
  });

  group('Login Success - Status 200', () {
    test('login success', () async {
      // act
      String? token = await authRepository!.login(
        'lambiengcode11@gmail.com',
        '123123',
        token: '',
      );

      // assert
      expect(token, isNotNull);
    });
  });

  group('Register Fail - Status Code 500', () {
    test('register fail', () async {
      // act
      bool result = await authRepository!.register(
        fistName: 'Dao',
        lastName: 'Hong Vinh',
        username: 'lambiengcode99@gmail.com',
        password: '123123',
        token: '',
      );

      // assert
      expect(result, false);
    });
  });

  group('Get info user', () {
    test('get info user success', () async {
      String? token = await authRepository!.login(
        'lambiengcode11@gmail.com',
        '123123',
        token: '',
      );

      UserModel? user = await userRepository!.getInfoUser(token: token);

      expect(user!.lastName, 'Bảo Phương');
    });
  });

  group('Get list class', () {
    test('get success', () async {
      String? token = await authRepository!.login(
        'lambiengcode11@gmail.com',
        '123123',
        token: '',
      );

      List<ClassModel> classes = await classRepository!.getListClasses(
        skip: 0,
        token: token,
      );

      expect(classes.length, greaterThan(0));
    });
  });

  group('Get list recommend class', () {
    test('get list recommend success', () async {
      String? token = await authRepository!.login(
        'lambiengcode11@gmail.com',
        '123123',
        token: '',
      );

      List<ClassModel> classes = await classRepository!.getListRecommendClasses(
        skip: 0,
        token: token,
      );

      expect(classes.length, greaterThan(0));
    });
  });
}
