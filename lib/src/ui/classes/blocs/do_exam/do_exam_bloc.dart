import 'package:bloc/bloc.dart';
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
  String? roomId;

  @override
  Stream<DoExamState> mapEventToState(DoExamEvent event) async* {
    if (event is CreateQuizEvent) {
      _resetUsers();
      _createQuiz(examId: event.examId);
    }

    if (event is CreateQuizSuccessEvent) {
      _createQuizSuccess(roomId: event.roomId);
      _setCurrentRoomId(roomId: event.roomId);
      yield InLobby(users: users);
    }

    if (event is StartQuizEvent) {
      _startQuiz();
    }

    if (event is JoinQuizEvent) {
      _setCurrentRoomId(roomId: event.roomId);
      _joinQuiz(roomId: event.roomId);
    }

    if (event is JoinQuizSuccessEvent) {
      _setUsers(users: event.users);
    }

    if (event is NewUserJoined) {
      yield InLobby(users: users);
      _newUser(user: event.user);
      yield InLobby(users: users);
    }

    if (event is AnswerQuestionEvent) {
      _answerQuestion(answer: event.answer);
    }

    if (event is TakeQuestionEvent) {
      _setCurrentQuestion(question: event.question);
      yield DoingQuestion(question: currentQuestion!);
    }

    if (event is UpdateStatisticEvent) {
      _setLastStatistic(statistic: event.statistic);
      yield DoingQuestion(question: currentQuestion!);
    }

    if (event is LeaveUserJoined) {
      _removeUser(userId: event.userId);
      _leaveQuiz();
    }

    if (event is FinishQuizEvent) {
      _leaveQuiz();
    }
  }

  // MARK: - Event handle function
  void _createQuiz({required String examId}) {
    SocketEmit().createQuiz(examId: examId);
  }

  void _createQuizSuccess({required String roomId}) {
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
    int index = users.indexWhere((user) => user.id == userId);
    if (index != -1) {
      users.removeAt(index);
    }
  }

  void _setUsers({required List<UserModel> users}) async {
    this.users = users;
  }

  void _resetUsers() async {
    users.clear();
  }

  void _setCurrentQuestion({required QuestionModel question}) async {
    currentQuestion = question;
    AppNavigator.replaceWith(AppRoutes.DO_EXAM, arguments: {
      'questionModel': question,
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

  void _leaveQuiz() {
    AppNavigator.pop();
  }
}
