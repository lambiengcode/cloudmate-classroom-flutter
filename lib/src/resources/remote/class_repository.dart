import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/resources/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class ClassRepository {
  Future<ClassModel?> createClass({
    required String name,
    required String topic,
    required String intro,
  }) async {
    var body = {
      'name': name,
      'topic': topic,
      'intro': intro,
    };

    Response? response =
        await BaseRepository().postRoute(ApiGateway.GET_INFO, body);

    if ([200, 201].contains(response!.statusCode)) {
      return ClassModel.fromMap(response.data);
    }

    return null;
  }
}
