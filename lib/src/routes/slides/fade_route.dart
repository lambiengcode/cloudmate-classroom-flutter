import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Duration duration;

  FadeRoute({this.page, this.duration = const Duration(milliseconds: 150)})
      : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(opacity: animation, child: page),
        );
}
