import 'package:cloudmate/src/models/road_map_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class RoadMapRepository {
  Future<RoadMapModel?> createRoadMap({
    required String classId,
    required String name,
    required String description,
  }) async {
    var body = {
      'name': name,
      'description': description,
    };

    Response response = await BaseRepository().postRoute(
      ApiGateway.ROAD_MAP,
      body,
      query: 'idClass=$classId',
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResult = response.data['data'];
      return RoadMapModel.fromMap(jsonResult);
    }

    return null;
  }

  Future<List<RoadMapModel>> getRoadMaps({required String classId}) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.ROAD_MAP,
      query: 'idClass=$classId',
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResult = response.data['data'];
      return jsonResult.map<RoadMapModel>((json) => RoadMapModel.fromMap(json)).toList();
    }

    return [];
  }

  Future<bool> deleteRoadMap({required String roadMapId}) async {
    Response response = await BaseRepository().deleteRoute(
      ApiGateway.ROAD_MAP,
      query: 'id=$roadMapId&status=0',
    );

    return [200, 201].contains(response.statusCode);
  }
}
