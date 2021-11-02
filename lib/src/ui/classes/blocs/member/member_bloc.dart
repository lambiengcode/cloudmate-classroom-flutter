import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:meta/meta.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc() : super(MemberInitial());

  List<UserModel> listMember = [];

  @override
  Stream<MemberState> mapEventToState(MemberEvent event) async* {}
}

// Mark: - Event handle function

// Future<void> _getMembers(String classId) async {}

// Future<void> _removeMember(String classId, String memberId) async {}
