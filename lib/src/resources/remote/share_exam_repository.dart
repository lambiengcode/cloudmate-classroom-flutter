import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class ShareExamRepository {
  Future<ExamModel?> createExam({
    required String name,
    required String description,
  }) async {
    var body = {
      "name": name,
      "description": description,
    };
    Response response = await BaseRepository().postRoute(ApiGateway.SET_OF_QUESTIONS_SHARE, body);
    if ([200, 201].contains(response.statusCode)) {
      dynamic jsonResponse = response.data['data'];
      return ExamModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<ExamModel>> getListExam() async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.SET_OF_QUESTIONS_SHARE,
      query: 'status=1',
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => ExamModel.fromMap(item)).toList();
    }
    return [];
  }
}
