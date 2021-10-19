import 'package:cloudmate/src/ui/classes/screens/create_class_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_deadline_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_question_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_roadmap_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/do_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_questions_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_request_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/lobby_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/road_map_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/statistic_in_exam_screen.dart';
import 'package:cloudmate/src/ui/notification/notification_screen.dart';
import 'package:cloudmate/src/ui/profile/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/app.dart';
import 'package:cloudmate/src/models/slide_mode.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/routes/slides/slide_from_bottom_route.dart';
import 'package:cloudmate/src/routes/slides/slide_from_left_route.dart';
import 'package:cloudmate/src/routes/slides/slide_from_right_route.dart';
import 'package:cloudmate/src/routes/slides/slide_from_top_route.dart';
import 'package:cloudmate/src/ui/classes/screens/class_information_screen.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  SlideMode defautlSlide = SlideMode.right;
  Route<dynamic> getRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments = _getArguments(settings);
    switch (settings.name) {
      case AppRoutes.ROOT:
        return _buildRoute(
          settings,
          App(),
          _getSlideMode(arguments),
        );
      case AppRoutes.NOTIFICATION:
        return _buildRoute(
          settings,
          NotificationScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.DETAILS_CLASS:
        return _buildRoute(
          settings,
          ClassInformationScreen(
            classModel: arguments!['classModel'],
            hasJoinedClass: arguments['hasJoinedClass'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_CLASS:
        return _buildRoute(
          settings,
          CreateClassScreen(
            classModel: arguments!['classModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.LIST_REQUEST:
        return _buildRoute(
          settings,
          ListRequestClassScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.LIST_EXAM:
        return _buildRoute(
          settings,
          ListExamScreen(
            classId: arguments!['classId'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_EXAM:
        return _buildRoute(
          settings,
          CreateExamScreen(
            classId: arguments!['classId'],
            examBloc: arguments['examBloc'],
            examModel: arguments['examModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.LIST_QUESTION:
        return _buildRoute(
          settings,
          ListQuestionScreen(
            examModel: arguments!['examModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_QUESTION:
        return _buildRoute(
          settings,
          CreateQuestionScreen(
            examId: arguments!['examId'],
            questionBloc: arguments['questionBloc'],
            questionModel: arguments['questionModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.ROAD_MAP:
        return _buildRoute(
          settings,
          RoadMapScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_ROAD_MAP:
        return _buildRoute(
          settings,
          CreateRoadmapScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_DEADLINE:
        return _buildRoute(
          settings,
          CreateDeadlineScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.LOBBY_EXAM:
        return _buildRoute(
          settings,
          LobbyScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.STATISTIC_QUESTION:
        return _buildRoute(
          settings,
          StatisticInExamScreen(),
          _getSlideMode(arguments),
        );
      case AppRoutes.DO_EXAM:
        return _buildRoute(
          settings,
          DoExamScreen(),
          _getSlideMode(arguments),
        );

      // User
      case AppRoutes.EDIT_INFO_USER:
        return _buildRoute(
          settings,
          EditInfoScreen(),
          _getSlideMode(arguments),
        );
      default:
        return _buildRoute(settings, App(), SlideMode.right);
    }
  }

  _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
    SlideMode slideMode,
  ) {
    switch (slideMode) {
      case SlideMode.bot:
        return SlideFromBottomRoute(page: builder, settings: routeSettings);
      case SlideMode.top:
        return SlideFromTopRoute(page: builder, settings: routeSettings);
      case SlideMode.left:
        return SlideFromLeftRoute(page: builder, settings: routeSettings);
      case SlideMode.right:
        return SlideFromRightRoute(page: builder, settings: routeSettings);
    }
  }

  _getArguments(RouteSettings settings) {
    return settings.arguments;
  }

  _getSlideMode(Map<String, dynamic>? arguments) {
    if (arguments == null) {
      return SlideMode.right;
    } else {
      return arguments['slide'] ?? SlideMode.right;
    }
  }

  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) =>
      state.popUntil(ModalRoute.withName(route));

  static void pop() {
    if (state.canPop()) {
      state.pop();
    }
  }

  static String currentRoute(context) => ModalRoute.of(context)!.settings.name!;

  static NavigatorState get state => navigatorKey.currentState!;
}
