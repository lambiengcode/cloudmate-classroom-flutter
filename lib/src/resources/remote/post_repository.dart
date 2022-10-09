import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class PostRepository {
  Future<List<PostModel>> getListPostHome({
    int skip = 0,
    int limit = 15,
  }) async {
    Response? response = await BaseRepository().getRoute(
      ApiGateway.POST_HOME,
      query: 'skip=$skip&limit=$limit',
    );

    if ([200, 201].contains(response.statusCode)) {
      List rawData = response.data['data'];
      return rawData.map((e) => PostModel.fromMap(e)).toList();
    }

    return [];
  }

  Future<List<PostModel>> getListPostClass({
    int skip = 0,
    int limit = 15,
    required String classId,
  }) async {
    Response? response = await BaseRepository().getRoute(
      ApiGateway.POST_CLASS + '/$classId',
      query: 'skip=$skip&limit=$limit',
    );

    if ([200, 201].contains(response.statusCode)) {
      List rawData = response.data['data'];
      return rawData.map((e) => PostModel.fromMap(e)).toList();
    }

    return [];
  }

  Future<PostModel?> createPost({
    required String content,
    required String classId,
  }) async {
    var body = {
      'classId': classId,
      'content': content,
    };

    Response? response =
        await BaseRepository().postRoute(ApiGateway.POST, body);

    if ([200, 201].contains(response.statusCode)) {
      var rawData = response.data['data'];
      return PostModel.fromMap(rawData);
    }

    return null;
  }
}
