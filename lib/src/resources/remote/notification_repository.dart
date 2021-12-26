import 'package:cloudmate/src/models/notification_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotifications() async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.NOTIFICATION,
    );
    print(response.data.toString());
    if (response.statusCode == 200) {
      List<dynamic> resultJson = response.data['data'];
      return resultJson.map((item) => NotificationModel.fromMap(item)).toList();
    }

    return [];
  }
}
