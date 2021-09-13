import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_2school/main.dart';
import 'package:flutter_mobile_2school/src/blocs/app_bloc.dart';
import 'package:flutter_mobile_2school/src/routes/app_pages.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:flutter_mobile_2school/src/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    themeService.initThemeMode();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: MultiProvider(
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
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: AppRoutes.ROOT,
              theme: AppTheme.light().data,
              darkTheme: AppTheme.dark().data,
              themeMode: context.watch<ThemeService>().getThemeMode(),
              onGenerateRoute: (settings) => AppPages().getRoute(settings),
            );
          },
        ),
      ),
    );
  }
}
