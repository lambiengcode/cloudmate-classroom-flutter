import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/public/sockets.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void connectAndListen() async {
  disconnectBeforeConnect();
  String socketUrl = Application.baseUrl!;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder().enableForceNew().setTransports(['websocket']).setExtraHeaders({
      'authorization': UserLocal().getAccessToken(),
    }).build(),
  );
  socket!.connect();
  socket!.onConnect((_) {
    debugPrint('connected');

    socket!.on(SocketEvent.CREATE_QUIZ_SSC, (data) {
      UtilLogger.log('CREATE_QUIZ_SSC', data);
      AppBloc.doExamBloc.add(CreateQuizSuccessEvent(roomId: data['idRoom']));
    });

    socket!.on(SocketEvent.JOIN_ROOM_SSC, (data) {
      UtilLogger.log('JOIN_ROOM_SSC', data);
      UserModel user = UserModel.fromMap(data['user']);
      AppBloc.doExamBloc.add(NewUserJoined(user: user));
    });

    socket!.on(SocketEvent.JOIN_ROOM_NEW_SSC, (data) {
      UtilLogger.log('JOIN_ROOM_NEW_SSC', data);
      List<dynamic> listResponse = data['users'];
      List<UserModel> users = listResponse.map((e) => UserModel.fromMap(e)).toList();
      AppBloc.doExamBloc.add(JoinQuizSuccessEvent(users: users));
    });

    socket!.on(SocketEvent.LEAVE_ROOM_SSC, (data) {
      UtilLogger.log('LEAVE_ROOM_SSC', data);
    });

    socket!.on(SocketEvent.STATISTICAL_ROOM_SSC, (data) {
      UtilLogger.log('STATISTICAL_ROOM_SSC', data);
      Map<dynamic, dynamic> statistical = data;
      List<String> answers = statistical.keys.map((e) => e.toString()).toList();
      List<int> chooses = statistical.values.map((e) => int.parse(e.toString())).toList();
      AppBloc.doExamBloc.add(UpdateStatisticEvent(
        statistic: StatisticModel(answers: answers, chooses: chooses),
      ));
    });

    socket!.on(SocketEvent.START_QUIZ_SSC, (data) {
      UtilLogger.log('START_QUIZ_SSC', data);
    });

    socket!.on(SocketEvent.TAKE_THE_QUESTION_SSC, (data) {
      UtilLogger.log('TAKE_THE_QUESTION_SSC', data);
      if (data['data'] == null || data['data'] == 'null') {
        AppBloc.doExamBloc.add(FinishQuizEvent());
        return;
      }
      QuestionModel question = QuestionModel.fromMap(data['data']);
      AppBloc.doExamBloc.add(TakeQuestionEvent(question: question));
    });

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
