import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class RoadMapContentRepository {
  Future<RoadMapContentModel?> createRoadMapContent({
    required String classId,
    required String name,
    required String description,
  }) async {
    var body = {
      "name": name,
      "description": description,
      "classBy": classId,
    };
    Response response = await BaseRepository().postRoute(ApiGateway.ROAD_MAP_CONTENT, body);
    if ([200, 201].contains(response.statusCode)) {
      dynamic jsonResponse = response.data['data'];
      return RoadMapContentModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<RoadMapContentModel>> getListRoadMapContent({
    required String roadMapId,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.ROAD_MAP_CONTENT,
      query: "id=$roadMapId",
    );
    if ([200, 201].contains(response.statusCode)) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => RoadMapContentModel.fromJson(item)).toList();
    }

    return [];
  }

  Future<RoadMapContentModel?> editRoadMapContent({
    required String roadMapContentId,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.ROAD_MAP_CONTENT,
      query: "id=$roadMapContentId",
    );
    if ([200, 201].contains(response.statusCode)) {
      dynamic jsonResponse = response.data['data'];
      return RoadMapContentModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<bool> deleteRoadMapContent({
    required String roadMapContentId,
  }) async {
    Response response = await BaseRepository().deleteRoute(
      ApiGateway.ROAD_MAP_CONTENT,
      query: "id=$roadMapContentId",
    );
    if ([200, 201].contains(response.statusCode)) {
      return true;
    }

    return false;
  }
}
