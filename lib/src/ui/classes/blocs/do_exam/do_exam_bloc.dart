import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/count_down/count_down_bloc.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/statistic_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/services/socket/socket_emit.dart';
import 'package:meta/meta.dart';

part 'do_exam_event.dart';
part 'do_exam_state.dart';

class DoExamBloc extends Bloc<DoExamEvent, DoExamState> {
  DoExamBloc() : super(DoExamInitial());

  List<UserModel> users = [];
  QuestionModel? currentQuestion;
  StatisticModel? lastStatistic;
  String questionIndex = "1/1";
  String? roomId;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  int ping = 0;

  @override
  Stream<DoExamState> mapEventToState(DoExamEvent event) async* {
    if (event is CreateQuizEvent) {
      _resetUsers();
      _createQuiz(
        examId: event.examId,
        classId: event.classId,
        title: event.title,
        description: event.description,
      );
    }

    if (event is CreateQuizSuccessEvent) {
      if (state is! InLobby) {
        _setCurrentRoomId(roomId: event.roomId);
        _createQuizSuccess();
        yield InLobby(users: users);
      }
    }

    if (event is StartQuizEvent) {
      _startQuiz();
    }

    if (event is JoinQuizEvent) {
      _setCurrentRoomId(roomId: event.roomId);
      _joinQuiz(roomId: event.roomId);
    }

    if (event is JoinQuizSuccessEvent) {
      if (state is! InLobby) {
        _setUsers(users: event.users);
        _createQuizSuccess();
        yield InLobby(users: users);
        AppBloc.countDownBloc.add(StartCountDownEvent());
      }
    }

    if (event is NewUserJoined) {
      int index = users.indexWhere((item) => item.id == event.user.id);
      if (state is InLobby && index == -1) {
        yield InLobby(users: users);
        _newUser(user: event.user);
        yield InLobby(users: users);
        AppBloc.countDownBloc.add(ResetCountDownEvent());
      }
    }

    if (event is AnswerQuestionEvent) {
      _answerQuestion(answer: event.answer);
    }

    if (event is TakeQuestionEvent) {
      if (currentQuestion != null) {
        if (currentQuestion!.id != event.question.id) {
          _setCurrentQuestion(question: event.question, indexQuestion: event.indexQuestion);
          yield DoingQuestion(question: currentQuestion!, ping: ping);
        }
      } else {
        _setCurrentQuestion(question: event.question, indexQuestion: event.indexQuestion);
        yield DoingQuestion(question: currentQuestion!, ping: ping);
      }
    }

    if (event is UpdateStatisticEvent) {
      if (lastStatistic != null) {
        if (lastStatistic!.answers != event.statistic.answers) {
          _setLastStatistic(statistic: event.statistic);
        }
      } else {
        _setLastStatistic(statistic: event.statistic);
      }
    }

    if (event is LeaveUserJoined) {
      if (state is InLobby) {
        _removeUser(userId: event.userId);
        yield InLobby(users: users);
        if (users.isEmpty) {
          AppBloc.countDownBloc.add(EndCountDownEvent());
        } else {
          AppBloc.countDownBloc.add(ResetCountDownEvent());
        }
      }
    }

    if (event is FinishQuizEvent) {
      _leaveQuiz();
      AppBloc.countDownBloc.add(EndCountDownEvent());
      AppNavigator.push(AppRoutes.FINAL_STATISTIC_QUESTION, arguments: {
        'statisticModel': event.finalStatistic,
      });
      yield DoExamInitial();
    }

    if (event is QuitQuizEvent) {
      _leaveQuiz();
      yield DoExamInitial();
    }

    if (event is StartPingEvent) {
      _startPing();
    }

    if (event is EndPingEvent) {
      _endPing();
      if (state is! InLobby) {
        yield DoingQuestion(question: currentQuestion, ping: ping);
      }
    }
  }

  // MARK: - Event handle function
  void _createQuiz({
    required String examId,
    required String classId,
    required String title,
    required String description,
  }) {
    AppNavigator.pop();
    SocketEmit().createQuiz(
      examId: examId,
      classId: classId,
      title: title,
      description: description,
    );
  }

  void _createQuizSuccess() {
    AppNavigator.push(AppRoutes.LOBBY_EXAM, arguments: {
      'roomId': roomId,
    });
  }

  void _setCurrentRoomId({required String roomId}) {
    this.roomId = roomId;
  }

  void _joinQuiz({required String roomId}) {
    SocketEmit().joinQuiz(roomId: roomId);
  }

  void _startQuiz() {
    SocketEmit().startQuiz(roomId: roomId);
  }

  void _newUser({required UserModel user}) async {
    users.add(user);
  }

  void _removeUser({required String userId}) async {
    for (var i = 0; i < users.length; i++) {
      if (users[i].id == userId) {
        users.removeAt(i);
      }
    }
  }

  void _setUsers({required List<UserModel> users}) async {
    this.users = users;
  }

  void _resetUsers() async {
    users.clear();
  }

  void _setCurrentQuestion({required QuestionModel question, required String indexQuestion}) async {
    currentQuestion = question;
    questionIndex = indexQuestion;
    AppNavigator.replaceWith(AppRoutes.DO_EXAM, arguments: {
      'questionModel': question,
      'questionIndex': questionIndex,
    });
  }

  void _setLastStatistic({required StatisticModel statistic}) async {
    lastStatistic = statistic;
    AppNavigator.replaceWith(AppRoutes.STATISTIC_QUESTION, arguments: {
      'statisticModel': statistic,
    });
  }

  void _answerQuestion({required String answer}) async {
    SocketEmit().answerQuestion(
      roomId: roomId!,
      questionId: currentQuestion!.id,
      answer: answer,
    );
  }

  void _startPing() {
    startTime = DateTime.now();
    SocketEmit().pingToServer();
  }

  void _endPing() {
    endTime = DateTime.now();
    ping = endTime.difference(startTime).inMicroseconds;
    // Future.delayed(Duration(seconds: 5), () {
    //   _startPing();
    // });
  }

  void _leaveQuiz() {
    SocketEmit().leaveRoom(roomId: roomId);
    AppNavigator.pop();
  }
}
