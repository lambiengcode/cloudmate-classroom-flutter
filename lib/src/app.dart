import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:flutter_mobile_2school/src/ui/navigation/navigation.dart';

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
  Widget build(BuildContext context) {
    return Navigation();
  }
}
