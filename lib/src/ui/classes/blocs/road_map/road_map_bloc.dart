import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'road_map_event.dart';
part 'road_map_state.dart';

class RoadMapBloc extends Bloc<RoadMapEvent, RoadMapState> {
  RoadMapBloc() : super(RoadMapInitial());

  @override
  Stream<RoadMapState> mapEventToState(RoadMapEvent event) async* {}
}

// MARK: - Event handler function
