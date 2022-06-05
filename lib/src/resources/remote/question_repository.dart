import 'dart:io';

import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class QuestionRepository {
  Future<QuestionModel?> createQuestion({
    required String question,
    required String examId,
    required List<String> answers,
    required List<int> corrects,
    required int duration,
    required int score,
    required File? banner,
    required File? audio,
    required QuestionType type,
  }) async {
    var body = {
      "typeQuestion": type.getTypeNumber().toString(),
      "question": question,
      "answers": answers,
      "correct": corrects,
      "duration": duration,
      "idSetOfQuestions": examId,
      "score": score,
    };

    if (banner != null) {
      body['banner'] =
          await MultipartFile.fromFile(banner.path, filename: banner.path.split('/').last);
    }

    if (audio != null) {
      body['audio'] =
          await MultipartFile.fromFile(audio.path, filename: audio.path.split('/').last);
    }

    FormData formData = FormData.fromMap(body);

    Response response = await BaseRepository().sendFormData(ApiGateway.QUESTION, formData);

    print(response.data);

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = response.data['data'];
      return QuestionModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<QuestionModel>> importQuestions({
    required List<QuestionModel> questions,
    required String examId,
  }) async {
    var body = {
      "questions": questions.map((question) => question.toMap()).toList(),
    };

    Response response = await BaseRepository().postRoute(
      ApiGateway.IMPORT_EXCEL,
      body,
      query: 'idSetOfQuestion=$examId',
    );

    if ([200, 201].contains(response.statusCode)) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((question) => QuestionModel.fromMap(question)).toList();
    }

    return [];
  }

  Future<List<QuestionModel>> getListQuestion({
    required int skip,
    required String id,
  }) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.QUESTION,
      query: 'skip=$skip&idSetOfQuestions=$id',
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data['data'];
      return jsonResponse.map((item) => QuestionModel.fromMap(item)).toList();
    }

    return [];
  }

  Future<QuestionModel?> editQuestion({
    required String question,
    required String questionId,
    required List<String> answers,
    required List<int> correct,
    required int duration,
    required int score,
  }) async {
    var body = {
      "question": question,
      "answers": answers,
      "correct": correct,
      "duration": duration,
      "score": score,
    };

    Response response = await BaseRepository().patchRoute(
      ApiGateway.QUESTION,
      query: 'id=$questionId',
      body: body,
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = response.data['data'];
      return QuestionModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<bool> deleteQuestion({
    required String questionId,
  }) async {
    Response response = await BaseRepository().deleteRoute(
      ApiGateway.QUESTION,
      query: 'status=0&id=$questionId',
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
