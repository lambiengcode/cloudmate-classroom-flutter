import 'package:cloudmate/src/helpers/device_helper.dart';
import 'package:cloudmate/src/models/device_model.dart';
import 'package:cloudmate/src/public/sockets.dart';
import 'package:cloudmate/src/services/socket/socket.dart';
import 'package:cloudmate/src/utils/logger.dart';

class SocketEmit {
  createQuiz({
    required examId,
    required classId,
    required title,
    required description,
  }) {
    socket!.emit(SocketEvent.CREATE_QUIZ_CSS, {
      'idSetOfQuestions': examId,
      'idClass': classId,
      'title': title,
      'description': description,
    });
    // print(socket?.connected);
    // print(SocketEvent.CREATE_QUIZ_CSS +
    //     {
    //       'idSetOfQuestions': examId,
    //       'idClass': classId,
    //       'title': title,
    //       'description': description,
    //     }.toString());
  }

  joinQuiz({required roomId}) {
    UtilLogger.log('SocketEmit', 'joinQuiz - ' + 'roomId: $roomId');
    socket!.emit(SocketEvent.JOIN_ROOM_CSS, {
      'idRoom': roomId,
    });
  }

  leaveRoom({required roomId}) {
    socket!.emit(SocketEvent.LEAVE_ROOM_CSS, {
      'idRoom': roomId,
    });
  }

  startQuiz({required roomId}) {
    socket!.emit(SocketEvent.START_QUIZ_CSS, {
      'idRoom': roomId,
    });
  }

  answerQuestion({required String answer, required String roomId, required String questionId}) {
    socket!.emit(SocketEvent.ANSWER_THE_QUESTION_CSS, {
      'idRoom': roomId,
      'idQuestion': questionId,
      'answer': answer,
    });
  }

  pingToServer() {
    socket!.emit(SocketEvent.PING);
  }

  sendDeviceInfo() async {
    DeviceModel deviceModel = await getDeviceDetails();
    socket!.emit(
      SocketEvent.SEND_FCM_TOKEN_CSS,
      deviceModel.toMap(),
    );
  }

  joinRoomChat({required String idConversation}) {
    print("JOIN: $idConversation");
    socket!.emit(SocketEvent.JOIN_CONVERSATION_CSS, {'idConversation': idConversation});
  }

  leaveRoomChat({required String idConversation}) {
    print("LEAVE: $idConversation");
    socket!.emit(SocketEvent.LEAVE_CONVERSATION_CSS, {'idConversation': idConversation});
  }

  sendMessage({required String conversationId, required String messageId}) {
    var body = {
      'idConversation': conversationId,
      'idMessage': messageId,
    };

    print(body);
    socket!.emit(
      SocketEvent.SEEN_MESSAGE_CONVERSATION_CSS,
      body,
    );
  }
}
