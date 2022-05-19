import 'package:cloudmate/src/blocs/authentication/authentication_bloc.dart';
import 'package:cloudmate/src/blocs/bloc/transaction_bloc.dart';
import 'package:cloudmate/src/blocs/conversation/conversation_bloc.dart';
import 'package:cloudmate/src/blocs/count_down/count_down_bloc.dart';
import 'package:cloudmate/src/blocs/message/message_bloc.dart';
import 'package:cloudmate/src/blocs/post_class/post_class_bloc.dart';
import 'package:cloudmate/src/blocs/post_home/post_home_bloc.dart';
import 'package:cloudmate/src/blocs/schedules/schedules_bloc.dart';
import 'package:cloudmate/src/blocs/share_exam/share_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudmate/src/blocs/app_state/app_state_bloc.dart';
import 'package:cloudmate/src/blocs/application/application_bloc.dart';
import 'package:cloudmate/src/blocs/theme/theme_bloc.dart';

class AppBloc {
  static final appStateBloc = AppStateBloc();
  static final applicationBloc = ApplicationBloc();
  static final themeBloc = ThemeBloc();
  static final authBloc = AuthBloc();
  static final classBloc = ClassBloc();
  static final doExamBloc = DoExamBloc();
  static final conversationBloc = ConversationBloc();
  static final messageBloc = MessageBloc();
  static final shareExamBloc = ShareExamBloc();
  static final postHomeBloc = PostHomeBloc();
  static final postClassBloc = PostClassBloc();
  static final schedulesBloc = SchedulesBloc();
  static final countDownBloc = CountDownBloc();
  static final transactionBloc = TransactionBloc();

  static final List<BlocProvider> providers = [
    BlocProvider<AppStateBloc>(
      create: (context) => appStateBloc,
    ),
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<ClassBloc>(
      create: (context) => classBloc,
    ),
    BlocProvider<DoExamBloc>(
      create: (context) => doExamBloc,
    ),
    BlocProvider<ConversationBloc>(
      create: (context) => conversationBloc,
    ),
    BlocProvider<MessageBloc>(
      create: (context) => messageBloc,
    ),
    BlocProvider<ShareExamBloc>(
      create: (context) => shareExamBloc,
    ),
    BlocProvider<PostHomeBloc>(
      create: (context) => postHomeBloc,
    ),
    BlocProvider<PostClassBloc>(
      create: (context) => postClassBloc,
    ),
    BlocProvider<SchedulesBloc>(
      create: (context) => schedulesBloc,
    ),
    BlocProvider<CountDownBloc>(
      create: (context) => countDownBloc,
    ),
    BlocProvider<TransactionBloc>(
      create: (context) => transactionBloc,
    ),
  ];

  static void dispose() {
    appStateBloc.close();
    applicationBloc.close();
    themeBloc.close();
    authBloc.close();
    classBloc.close();
    doExamBloc.close();
    conversationBloc.close();
    messageBloc.close();
    shareExamBloc.close();
    postHomeBloc.close();
    postClassBloc.close();
    schedulesBloc.close();
    conversationBloc.close();
    transactionBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
