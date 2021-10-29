import 'package:cloudmate/src/public/sockets.dart';
import 'package:cloudmate/src/services/socket/socket.dart';

class SocketEmit {
  createQuiz({required examId}) {
    socket!.emit(SocketEvent.CREATE_QUIZ_CSS, {
      'idSetOfQuestions': examId,
    });
  }

  joinQuiz({required roomId}) {
    socket!.emit(SocketEvent.JOIN_ROOM_CSS, {
      'roomId': roomId,
    });
  }

  leaveRoom({required roomId}) {
    socket!.emit(SocketEvent.LEAVE_ROOM_CSS, {
      'roomId': roomId,
    });
  }

  startQuiz({required roomId}) {
    socket!.emit(SocketEvent.START_QUIZ_CSS, {
      'roomId': roomId,
    });
  }

  answerQuestion({required String answer}) {
    socket!.emit(SocketEvent.ANSWER_THE_QUESTION_SSC, {
      'answer': answer,
    });
  }
}
