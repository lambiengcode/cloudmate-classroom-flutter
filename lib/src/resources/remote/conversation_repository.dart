import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class ConversationRepository {
  Future<List<ConversationModel>> getListClasses({
    required int skip,
    int limit = 10,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.CONVERSATION,
      query: 'skip=$skip&limit=$limit',
    );
    if ([200].contains(response.statusCode)) {
      List<dynamic> listResult = response.data['data'];
      return listResult.map((e) => ConversationModel.fromMap(e)).toList();
    }

    return [];
  }
}
