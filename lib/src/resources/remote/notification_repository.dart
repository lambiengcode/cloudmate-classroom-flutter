import 'package:cloudmate/src/models/notification_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotifications({required int skip, int limit = 15}) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.NOTIFICATION,
      query: 'skip=$skip&limit=$limit',
    );
    if (response.statusCode == 200) {
      List<dynamic> resultJson = response.data;
      return resultJson.map((item) => NotificationModel.fromMap(item)).toList();
    }

    return [];
  }
}
