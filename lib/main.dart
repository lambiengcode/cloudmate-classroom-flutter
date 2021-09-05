import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/routes/app_pages.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:flutter_mobile_2school/src/themes/themes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

final GlobalKey<NavigatorState> navGlogbalKey = new GlobalKey<NavigatorState>();

void main() async {
  await GetStorage.init();
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
            title: '2School!',
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
