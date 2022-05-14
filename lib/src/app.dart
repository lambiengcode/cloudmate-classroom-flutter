import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/language.dart';
import 'package:cloudmate/src/ui/authentication/authentication_screen.dart';
import 'package:cloudmate/src/ui/navigation/navigation.dart';
import 'package:cloudmate/src/ui/splash/splash_screen.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/bloc.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/themes/themes.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationBloc.add(OnSetupApplication());
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
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, theme) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, auth) {
              return Sizer(
                builder: (context, orientation, deviceType) {
                  return I18n(
                    child: GetMaterialApp(
                      navigatorKey: AppNavigator.navigatorKey,
                      debugShowCheckedModeBanner: false,
                      title: 'Cloudmate',
                      locale: AppLanguage.defaultLanguage,
                      supportedLocales: AppLanguage.supportLanguage,
                      localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      theme: AppTheme.light().data,
                      darkTheme: AppTheme.dark().data,
                      themeMode: ThemeService.currentTheme,
                      onGenerateRoute: (settings) {
                        return AppNavigator().getRoute(settings);
                      },
                      home: BlocBuilder<ApplicationBloc, ApplicationState>(
                        builder: (context, application) {
                          if (application is ApplicationCompleted) {
                            if (auth is AuthenticationFail) {
                              return AuthenticateScreen();
                            }
                            if (auth is AuthenticationSuccess) {
                              return Navigation();
                            }
                          }
                          return SplashScreen();
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
