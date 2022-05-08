import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class RoadMapContentRepository {
  Future<RoadMapContentModel?> createRoadMapContent({
    bool isCreateAssignment = true,
    required String classId,
    required String roadMapId,
    required String name,
    required String startTime,
    required String endTime,
    required List<String>? fileExtensions,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "description": 'description',
      "startTime": startTime,
      "endTime": endTime,
    };

    if (fileExtensions != null) {
      body["fileExtensions"] = fileExtensions;
    }
    Response response = await BaseRepository().postRoute(
      isCreateAssignment
          ? ApiGateway.ROAD_MAP_CONTENT_ASSIGNMENT
          : ApiGateway.ROAD_MAP_CONTENT_ATTENDANCE,
      body,
      query: 'idClass=$classId&idRoadMap=$roadMapId',
    );

    if ([200, 201].contains(response.statusCode)) {
      dynamic jsonResponse = response.data['data'];
      return RoadMapContentModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<RoadMapContentModel>> getListRoadMapContent({
    required String roadMapId,
    required String classId,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.ROAD_MAP_CONTENT,
      query: 'idClass=$classId&idRoadMap=$roadMapId',
    );
    if ([200, 201].contains(response.statusCode)) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => RoadMapContentModel.fromMap(item)).toList();
    }

    return [];
  }

  Future<List<RoadMapContentModel>> getSchedules({
    required String month,
    required String year,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.SCHEDULE,
      query: 'month=$month&year=$year',
    );

    if ([200, 201].contains(response.statusCode)) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => RoadMapContentModel.fromMapPost(item)).toList();
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
