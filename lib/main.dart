import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/routes/app_pages.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<NavigatorState> navGlogbalKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          navigatorKey: navGlogbalKey,
          debugShowCheckedModeBanner: false,
          title: '2School!',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: Locale('vi', 'VN'),
          initialRoute: AppRoutes.ROOT,
          onGenerateRoute: (settings) => AppPages().getRoute(settings),
        );
      },
    );
  }
}
