import 'package:flutter/material.dart';

class SlideFromLeftRoute extends PageRouteBuilder {
  final Widget? page;
  final Duration duration;
  final RouteSettings settings;
  SlideFromLeftRoute(
      {required this.settings,
      this.page,
      this.duration = const Duration(milliseconds: 200)})
      : super(
          settings: settings,
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
