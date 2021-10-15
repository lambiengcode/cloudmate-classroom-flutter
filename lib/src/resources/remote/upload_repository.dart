import 'dart:io';
import 'package:cloudmate/src/models/upload_response_model.dart';
import 'package:cloudmate/src/public/api_gateway.dart';
import 'package:cloudmate/src/resources/base_repository.dart';
import 'package:dio/dio.dart';

class UploadRepository {
  Future<UploadResponseModel?> uploadSingleFile({
    required File file,
  }) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromBytes(
        file.readAsBytesSync(),
        filename: file.path,
      ),
    });

    Response response = await BaseRepository().sendFormData(
      ApiGateway.UPLOAD_SINGLE_FILE,
      formData,
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = await response.data['data'];
      return UploadResponseModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<UploadResponseModel>?> uploadMultipleFile({
    required List<File> files,
  }) async {
    List filesBody = [];
    files.forEach((item) async {
      filesBody.add(await MultipartFile.fromBytes(
        item.readAsBytesSync(),
        filename: item.path,
      ));
    });
    FormData formData = FormData.fromMap({
      'files': files,
    });

    Response response = await BaseRepository().sendFormData(
      ApiGateway.UPLOAD_MULTIPLE_FILE,
      formData,
    );

    if ([200, 201].contains(response.statusCode)) {
      List jsonResponses = await response.data['data'];
      return jsonResponses
          .map((item) => UploadResponseModel.fromMap(item))
          .toList();
    }

    return null;
  }
}
