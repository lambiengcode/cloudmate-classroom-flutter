import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/history_quiz_model.dart';
import 'package:cloudmate/src/resources/remote/history_quiz_repository.dart';
import 'package:meta/meta.dart';

part 'history_quiz_event.dart';
part 'history_quiz_state.dart';

class HistoryQuizBloc extends Bloc<HistoryQuizEvent, HistoryQuizState> {
  HistoryQuizBloc() : super(HistoryQuizInitial());

  List<HistoryQuizModel> _historyQuizList = [];

  @override
  Stream<HistoryQuizState> mapEventToState(HistoryQuizEvent event) async* {
    yield HistoryQuizInitial();
    _fetchHistoryQuiz();
    yield GetDoneHistoryQuiz(_historyQuizList);
  }

  // MARK: - private methods
  Future<void> _fetchHistoryQuiz() async {
    List<HistoryQuizModel> historyQuizList = await HistoryQuizRepository().getHistory();
    if (historyQuizList.isNotEmpty) {
      _historyQuizList = historyQuizList;
    }
  }
}
