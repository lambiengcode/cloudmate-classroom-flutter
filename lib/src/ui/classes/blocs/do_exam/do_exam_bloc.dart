import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'do_exam_event.dart';
part 'do_exam_state.dart';

class DoExamBloc extends Bloc<DoExamEvent, DoExamState> {
  DoExamBloc() : super(DoExamInitial());

  @override
  Stream<DoExamState> mapEventToState(DoExamEvent event) async* {}
}

// MARK: - Event handle function

Future<void> _addQuestion() async {}

Future<void> _updateStatistic() async {}

Future<void> _startTime() async {}

