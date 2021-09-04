import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/app.dart';
import 'package:flutter_mobile_2school/src/models/slide_mode.dart';
import 'package:flutter_mobile_2school/src/routes/app_routes.dart';
import 'package:flutter_mobile_2school/src/routes/slides/slide_from_bottom_route.dart';
import 'package:flutter_mobile_2school/src/routes/slides/slide_from_left_route.dart';
import 'package:flutter_mobile_2school/src/routes/slides/slide_from_right_route.dart';
import 'package:flutter_mobile_2school/src/routes/slides/slide_from_top_route.dart';

class AppPages {
  SlideMode defautlSlide = SlideMode.right;
  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.ROOT:
        Map<String, dynamic>? arguments = _getArguments(settings);
        return _buildRoute(settings, App(), _getSlideMode(arguments));
      default:
        return _buildRoute(settings, App(), SlideMode.right);
    }
  }

  _buildRoute(
      RouteSettings routeSettings, Widget builder, SlideMode slideMode) {
    switch (slideMode) {
      case SlideMode.bot:
        return SlideFromBottomRoute(page: builder);
      case SlideMode.top:
        return SlideFromTopRoute(page: builder);
      case SlideMode.left:
        return SlideFromLeftRoute(page: builder);
      case SlideMode.right:
        return SlideFromRightRoute(page: builder);
    }
  }

  _getArguments(RouteSettings? settings) {
    return (settings!.arguments);
  }

  _getSlideMode(Map<String, dynamic>? arguments) {
    if (arguments == null) {
      return SlideMode.right;
    } else {
      return arguments['slide'];
    }
  }
}
