import 'package:cloudmate/src/public/sockets.dart';
import 'package:cloudmate/src/services/socket/socket.dart';
import 'package:cloudmate/src/utils/logger.dart';

class SocketEmit {
  createQuiz({required examId}) {
    socket!.emit(SocketEvent.CREATE_QUIZ_CSS, {
      'idSetOfQuestions': examId,
    });
  }

  joinQuiz({required roomId}) {
    UtilLogger.log('SocketEmit', 'joinQuiz - ' + 'roomId: $roomId');
    socket!.emit(SocketEvent.JOIN_ROOM_CSS, {
      'idRoom': roomId,
    });
  }

  leaveRoom({required roomId}) {
    socket!.emit(SocketEvent.LEAVE_ROOM_CSS, {
      'roomId': roomId,
    });
  }

  startQuiz({required roomId}) {
    socket!.emit(SocketEvent.START_QUIZ_CSS, {
      'idRoom': roomId,
    });
  }

  answerQuestion({required String answer, required String roomId, required String questionId}) {
    print('answerQuestion :' + {
      'idRoom': roomId,
      'idQuestion': questionId,
      'answer': answer,
    }.toString());
    socket!.emit(SocketEvent.ANSWER_THE_QUESTION_CSS, {
      'idRoom': roomId,
      'idQuestion': questionId,
      'answer': answer,
    });
  }
}
