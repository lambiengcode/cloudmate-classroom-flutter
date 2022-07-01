import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:meta/meta.dart';

part 'count_down_event.dart';
part 'count_down_state.dart';

class CountDownBloc extends Bloc<CountDownEvent, CountDownState> {
  CountDownBloc() : super(CountDownInitial());

  int duration = 30;
  bool flagTimer = false;

  @override
  Stream<CountDownState> mapEventToState(CountDownEvent event) async* {
    if (event is StartCountDownEvent) {
      flagTimer = false;
      await _onStart();
      yield _inProgress;
    }

    if (event is ResetCountDownEvent) {
      flagTimer = false;
      duration = 30;
      yield _inProgress;
      await _onStart();
    }

    if (event is UpdateCountDownEvent) {
      await _onStart();
      yield _inProgress;
    }

    if (event is EndCountDownEvent) {
      flagTimer = true;
      duration = 30;
      yield CountDownInitial();
    }
  }

  // MARK: Private methods
  InProgressCountDown get _inProgress => InProgressCountDown(duration: duration);

  Future<void> _onStart() async {
    if (!flagTimer) {
      await Future.delayed(Duration(seconds: 1), () {
        if (duration > 0) {
          duration--;
        }
        if (duration == 0) {
          if (AppBloc.doExamBloc.users
                  .indexWhere((user) => user.id == AppBloc.authBloc.userModel?.id) ==
              -1) {
            AppBloc.doExamBloc.add(StartQuizEvent());
          } else {
            add(EndCountDownEvent());
          }
        } else {
          add(UpdateCountDownEvent());
        }
      });
    }
  }
}
