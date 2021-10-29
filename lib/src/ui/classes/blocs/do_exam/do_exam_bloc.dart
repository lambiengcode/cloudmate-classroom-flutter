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

  @override
  Stream<DoExamState> mapEventToState(DoExamEvent event) async* {
    if (event is CreateQuizEvent) {
      _resetUsers();
      _createQuiz(examId: event.examId);
      yield InLobby();
    }

    if (event is CreateQuizSuccessEvent) {
      _createQuizSuccess(roomId: event.roomId);
      yield InLobby();
    }

    if (event is StartQuizEvent) {
      _startQuiz(roomId: event.roomId);
    }

    if (event is JoinQuizEvent) {
      _setUsers(users: event.users);
      yield InLobby();
    }

    if (event is NewUserJoined) {
      _newUser(user: event.user);
      yield InLobby();
    }

    if (event is AnswerQuestionEvent) {
      yield DoingQuestion(question: currentQuestion!);
    }

    if (event is TakeQuestionEvent) {
      yield DoingQuestion(question: currentQuestion!);
    }

    if (event is UpdateStatisticEvent) {
      yield DoingQuestion(question: currentQuestion!);
    }

    if (event is LeaveUserJoined) {
      yield InLobby();
      _removeUser(userId: event.userId);
      yield InLobby();
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

  void _startQuiz({required roomId}) {
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
  }

  void _setLastStatistic({required StatisticModel statistic}) async {
    lastStatistic = statistic;
  }
}
