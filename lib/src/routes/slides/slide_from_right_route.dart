import 'package:flutter/material.dart';

class SlideFromRightRoute extends PageRouteBuilder {
  final Widget? page;
  final Duration duration;
  final RouteSettings settings;
  SlideFromRightRoute(
      {required this.settings,
      this.page,
      this.duration = const Duration(milliseconds: 200)})
      : super(
            settings: settings,
            pageBuilder: (context, animation, anotherAnimation) => page!,
            transitionDuration: duration,
            reverseTransitionDuration: Duration(milliseconds: 340),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return SlideTransition(
                position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                    .animate(animation),
                child: page,
              );
            });
}
