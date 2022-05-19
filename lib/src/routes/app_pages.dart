import 'package:cloudmate/src/routes/scaffold_wrapper.dart';
import 'package:cloudmate/src/ui/classes/screens/create_class_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_deadline_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_question_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_road_map_content_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/create_roadmap_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/details_history_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/do_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/history_quiz_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_questions_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/list_request_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/lobby_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/members_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/road_map_content_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/road_map_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/share_exam_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/statistic_final_screen.dart';
import 'package:cloudmate/src/ui/classes/screens/statistic_in_exam_screen.dart';
import 'package:cloudmate/src/ui/conversation/conversation_screen.dart';
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
      case AppRoutes.LIST_MEMBERS:
        return _buildRoute(
          settings,
          MembersScreen(
            classModel: arguments!['classModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.LIST_EXAM:
        return _buildRoute(
          settings,
          ListExamScreen(
            classModel: arguments!['classModel'],
            isPickedMode: arguments['isPickedMode'] ?? false,
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_EXAM:
        return _buildRoute(
          settings,
          CreateExamScreen(
            classId: arguments?['classId'],
            examBloc: arguments?['examBloc'],
            examModel: arguments?['examModel'],
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
      case AppRoutes.LIST_SHARE_EXAM:
        return _buildRoute(
          settings,
          ShareExamScreen(),
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
          RoadMapScreen(
            classModel: arguments!['classModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_ROAD_MAP:
        return _buildRoute(
          settings,
          CreateRoadmapScreen(
            classModel: arguments!['classModel'],
            roadMapBloc: arguments['roadMapBloc'],
            roadMapModel: arguments['roadMapModel'],
          ),
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
          LobbyScreen(
            roomId: arguments!['roomId'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.STATISTIC_QUESTION:
        return _buildRoute(
          settings,
          StatisticInExamScreen(
            statisticModel: arguments!['statisticModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.FINAL_STATISTIC_QUESTION:
        return _buildRoute(
          settings,
          StatisticFinalScreen(
            statisticModel: arguments!['statisticModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.DO_EXAM:
        return _buildRoute(
          settings,
          DoExamScreen(
            questionModel: arguments!['questionModel'],
            questionIndex: arguments['questionIndex'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.HISTORY_EXAM:
        return _buildRoute(
          settings,
          HistoryQuizScreen(classId: arguments!['classId']),
          _getSlideMode(arguments),
        );
      case AppRoutes.DETAILS_HISTORY_EXAM:
        return _buildRoute(
          settings,
          DetailsHistoryScreen(
            users: arguments!['users'],
            title: arguments['title'],
            score: arguments['score'],
          ),
          _getSlideMode(arguments),
        );

      // Road Map Content
      case AppRoutes.ROAD_MAP_CONTENT:
        return _buildRoute(
          settings,
          RoadMapContentScreen(
            roadMapModel: arguments!['roadMapModel'],
            roadMapBloc: arguments['roadMapBloc'],
            classModel: arguments['classModel'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.CREATE_ROAD_MAP_CONTENT:
        return _buildRoute(
          settings,
          CreateRoadmapContentScreen(
            roadMapContentBloc: arguments!['roadMapContentBloc'],
            classId: arguments['classId'],
            roadMapId: arguments['roadMapId'],
          ),
          _getSlideMode(arguments),
        );

      // User
      case AppRoutes.EDIT_INFO_USER:
        return _buildRoute(
          settings,
          EditInfoScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.CONVERSATION:
        return _buildRoute(
          settings,
          ConversationScreen(conversation: arguments!['conversationModel']),
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
        return SlideFromBottomRoute(page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.top:
        return SlideFromTopRoute(page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.left:
        return SlideFromLeftRoute(page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.right:
        return SlideFromRightRoute(page: ScaffoldWrapper(child: builder), settings: routeSettings);
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

  static void popUntil<T>(String route) => state.popUntil(ModalRoute.withName(route));

  static void pop() {
    if (state.canPop()) {
      state.pop();
    }
  }

  static String currentRoute(context) => ModalRoute.of(context)!.settings.name!;

  static NavigatorState get state => navigatorKey.currentState!;
}
