import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_2school/src/routes/app_pages.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:flutter_mobile_2school/src/themes/themes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navGlogbalKey = new GlobalKey<NavigatorState>();
var baseUrl;
var socketUrl;

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  try {
    baseUrl = dotenv.env['BASE_URL'];
    socketUrl = dotenv.env['SOCKET_URL'];
  } catch (error) {
    debugPrint(error.toString());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(
          create: (context) => themeService,
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            navigatorKey: navGlogbalKey,
            debugShowCheckedModeBanner: false,
            title: 'Cloudmate',
            locale: Locale('vi', 'VN'),
            initialRoute: AppRoutes.ROOT,
            theme: AppTheme.light().data,
            darkTheme: AppTheme.dark().data,
            themeMode: context.watch<ThemeService>().getThemeMode(),
            onGenerateRoute: (settings) => AppPages().getRoute(settings),
          );
        },
      ),
    );
  }
}
