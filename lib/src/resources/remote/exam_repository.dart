import 'package:cloudmate/src/models/exam_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class ExamRepository {
  Future<ExamModel?> createExam({
    required String classId,
    required String name,
    required String description,
  }) async {
    var body = {
      "name": name,
      "description": description,
      "classBy": classId,
    };
    Response response = await BaseRepository().postRoute(ApiGateway.SET_OF_QUESTIONS, body);
    if ([200, 201].contains(response.statusCode)) {
      dynamic jsonResponse = response.data['data'];
      return ExamModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<ExamModel>> getListExam({
    required String classId,
    required int skip,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.SET_OF_QUESTIONS,
      query: 'classId=$classId&status=1&skip=$skip&limit=15',
    );

    if (response.statusCode == 200) {
      print(response.data);
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse
          .where((element) => element is! List)
          .map((item) => ExamModel.fromMap(item))
          .toList();
    }
    return [];
  }

  Future<ExamModel?> updateExam({
    required String examId,
    required String name,
    required String description,
  }) async {
    var body = {
      'name': name,
      'description': description,
    };
    Response response = await BaseRepository().patchRoute(
      ApiGateway.SET_OF_QUESTIONS,
      query: 'id=$examId',
      body: body,
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = response.data['data'];
      return ExamModel.fromMap(jsonResponse);
    }
    return null;
  }

  Future<bool> deleteExam({
    required String examId,
  }) async {
    Response response = await BaseRepository().deleteRoute(
      ApiGateway.SET_OF_QUESTIONS,
      query: 'status=0&id=$examId',
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
