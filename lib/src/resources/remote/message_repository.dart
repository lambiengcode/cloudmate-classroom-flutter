import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class MessageRepository {
  Future<List<MessageModel>> getMessages({
    required String classId,
    required int skip,
    int limit = 15,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.MESSAGE_CONVERSATION + '/$classId',
      query: 'skip=$skip&limit=$limit',
    );
    if ([200].contains(response.statusCode)) {
      List<dynamic> listResult = response.data['data'];
      return listResult.map((e) => MessageModel.fromMap(e)).toList();
    }

    return [];
  }

  Future<MessageModel?> createMessage({
    required String idClass,
    required String message,
  }) async {
    var body = {
      'idClass': idClass,
      'message': message,
    };
    Response response = await BaseRepository().postRoute(
      ApiGateway.MESSAGE,
      body,
    );
    if ([201].contains(response.statusCode)) {
      var item = response.data['data'];
      return MessageModel.fromMapCreate(item);
    }

    return null;
  }
}
