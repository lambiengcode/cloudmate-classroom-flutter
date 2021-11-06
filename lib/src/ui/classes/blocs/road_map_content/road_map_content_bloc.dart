import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'road_map_content_event.dart';
part 'road_map_content_state.dart';

class RoadMapContentBloc extends Bloc<RoadMapContentEvent, RoadMapContentState> {
  RoadMapContentBloc() : super(RoadMapContentInitial());

  @override
  Stream<RoadMapContentState> mapEventToState(RoadMapContentEvent event) async* {
    
  }
}
