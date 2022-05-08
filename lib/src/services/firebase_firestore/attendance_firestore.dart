import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/user.dart';

class AttendanceFirestore {
  Future<List<UserModel>> getAttendance(String roadmapContentId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('attendances')
        .where('roadmapContentId', isEqualTo: roadmapContentId)
        .get();

    List<UserModel> users = [];

    for (int index = 0; index < snapshot.docs.length; index++) {
      QuerySnapshot snapshotUser = await FirebaseFirestore.instance
          .collection('users')
          .where('_id', isEqualTo: snapshot.docs[index]['userId'])
          .get();

      if (snapshotUser.docs.isNotEmpty) {
        users.add(UserModel.fromMap(snapshotUser.docs.first));
      }
    }

    return users;
  }

  Future<void> createAttendance(String roadmapContentId) async {
    await FirebaseFirestore.instance.collection('attendances').add({
      'roadmapContentId': roadmapContentId,
      'userId': AppBloc.authBloc.userModel?.id ?? '',
    });
  }
}
