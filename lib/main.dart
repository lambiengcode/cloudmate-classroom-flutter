import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobile_2school/src/blocs/common/app_bloc_delegate.dart';
import 'package:flutter_mobile_2school/src/routes/app_pages.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';

void main() {
  Bloc.observer = AppBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2School!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.ROOT,
      onGenerateRoute: (settings) => AppPages().getRoute(settings),
    );
  }
}
