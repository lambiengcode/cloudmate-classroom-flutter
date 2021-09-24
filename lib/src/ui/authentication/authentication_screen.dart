import 'package:cloudmate/src/ui/authentication/screens/login_screen.dart';
import 'package:cloudmate/src/ui/authentication/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  bool signIn = true;
  @override
  void initState() {
    super.initState();
  }

  switchScreen() {
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? LoginPage(
            toggleView: switchScreen,
          )
        : RegisterPage(
            toggleView: switchScreen,
          );
  }
}
