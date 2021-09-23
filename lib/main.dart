import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudmate/src/app.dart';
import 'package:cloudmate/src/utils/logger.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

void isolate2(String arg) {
  Timer.periodic(
      Duration(seconds: 10), (timer) => print("Timer Running From Isolate 2"));
}

void isolate1(String arg) async {
  await FlutterIsolate.spawn(isolate2, "hello2");

  Timer.periodic(
      Duration(seconds: 4), (timer) => print("Timer Running From Isolate 1"));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Isolate
  // final isolate = await FlutterIsolate.spawn(isolate1, "hello");
  // Timer(Duration(seconds: 5), () {
  //   print("Pausing Isolate 1");
  //   isolate.pause();
  // });
  // Timer(Duration(seconds: 10), () {
  //   print("Resuming Isolate 1");
  //   isolate.resume();
  // });
  // Timer(Duration(seconds: 20), () {
  //   print("Killing Isolate 1");
  //   isolate.kill();
  // });

  Bloc.observer = AppBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    UtilLogger.log('BLOC EVENT', event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    UtilLogger.log('BLOC ERROR', error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    UtilLogger.log('BLOC TRANSITION', transition.event);
    super.onTransition(bloc, transition);
  }
}
