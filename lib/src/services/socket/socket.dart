import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/message/message_bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/sockets.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:cloudmate/src/services/socket/socket_emit.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void connectAndListen() async {
  disconnectBeforeConnect();
  String socketUrl = Application.socketUrl;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder()
        .enableForceNew()
        .setTransports(['websocket']).setExtraHeaders({
      'authorization': UserLocal().getAccessToken(),
    }).build(),
  );
  socket!.connect();
  socket!.onConnect((_) async {
    debugPrint('connected');

    socket!.onPing((data) {
      AppBloc.doExamBloc.add(EndPingEvent());
    });

    socket!.on(SocketEvent.CREATE_QUIZ_SSC, (data) {
      UtilLogger.log('CREATE_QUIZ_SSC', data);
      if (data['success']) {
        AppBloc.doExamBloc.add(CreateQuizSuccessEvent(roomId: data['idRoom']));
      }
    });

    socket!.on(SocketEvent.JOIN_ROOM_SSC, (data) {
      UtilLogger.log('JOIN_ROOM_SSC', data);
      if (data['success']) {
        UserModel user = UserModel.fromMap(data['user']);
        AppBloc.doExamBloc.add(NewUserJoined(user: user));
      }
    });

    socket!.on(SocketEvent.JOIN_ROOM_NEW_SSC, (data) {
      UtilLogger.log('JOIN_ROOM_NEW_SSC', data);
      if (data['success']) {
        List<dynamic> listResponse = data['users'];
        List<UserModel> users =
            listResponse.map((e) => UserModel.fromMap(e)).toList();
        AppBloc.doExamBloc.add(JoinQuizSuccessEvent(users: users));
      }
    });

    socket!.on(SocketEvent.LEAVE_ROOM_SSC, (data) {
      UtilLogger.log('LEAVE_ROOM_SSC', data);
      if (data['success']) {
        AppBloc.doExamBloc
            .add(LeaveUserJoined(userId: data['data']['idUser']['_id']));
      }
    });

    socket!.on(SocketEvent.STATISTICAL_ROOM_SSC, (data) {
      UtilLogger.log('STATISTICAL_ROOM_SSC', data);
      if (data['success']) {
        Map<dynamic, dynamic> statistical = data['data'];
        List<String> answers =
            statistical.keys.map((e) => e.toString()).toList();
        List<int> chooses =
            statistical.values.map((e) => int.parse(e.toString())).toList();
        AppBloc.doExamBloc.add(UpdateStatisticEvent(
          statistic: StatisticModel(answers: answers, chooses: chooses),
        ));
      }
    });

    socket!.on(SocketEvent.START_QUIZ_SSC, (data) {
      UtilLogger.log('START_QUIZ_SSC', data);
    });

    socket!.on(SocketEvent.TAKE_THE_QUESTION_SSC, (data) {
      UtilLogger.log('TAKE_THE_QUESTION_SSC', data);
      if (data['success']) {
        if (data['data'] == null || data['data'] == 'null') {
          AppBloc.doExamBloc.add(QuitQuizEvent());
          return;
        }
        print(data['data']);
        QuestionModel question = QuestionModel.fromMap(data['data']);
        AppBloc.doExamBloc.add(TakeQuestionEvent(
            question: question, indexQuestion: data['data']['indexQuestion']));
      }
    });

    socket!.on('STATISTICAL_ROOM_FINAL_SSC', (data) {
      UtilLogger.log('STATISTICAL_ROOM_FINAL_SSC', data);
      if (data['success']) {
        Map<String, dynamic> statistical = data['data'];
        FinalStatisticModel finalStatistic =
            FinalStatisticModel.fromMap(statistical);
        AppBloc.doExamBloc.add(FinishQuizEvent(finalStatistic: finalStatistic));
      }
    });

    socket!.on('SEND_MESSAGE_CONVERSATION_SSC', (data) {
      print(SocketEvent.SEEN_MESSAGE_CONVERSATION_SSC + ': ${data.toString()}');
      AppBloc.messageBloc
          .add(InsertMessageEvent(message: MessageModel.fromMap(data['data'])));
    });

    SocketEmit().sendDeviceInfo();
    AppBloc.doExamBloc.add(StartPingEvent());

    socket!.onDisconnect((_) => debugPrint('disconnect'));
  });
}

void disconnectBeforeConnect() {
  if (socket != null) {
    if (socket!.connected) {
      socket!.disconnect();
    }
  }
}
