import 'package:dio/dio.dart' as diox;
import 'dart:convert' as convert;
import 'dart:async';

import 'package:cloudmate/src/configs/application.dart';

class BaseRepository {
  var dio = diox.Dio(diox.BaseOptions(
    baseUrl: Application.baseUrl!,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )); // with default Options

  Future<diox.Response<dynamic>> downloadFile(
      String url, String path, Function onReceive) async {
    var response = await dio.download(
      url,
      path,
      options: getOptions(),
      onReceiveProgress: (received, total) {
        onReceive(received, total);
      },
    );
    return response;
  }

  Future<diox.Response<dynamic>> sendFormData(
    String gateway,
    diox.FormData formData,
    Function onSend,
  ) async {
    var response = await dio.post(
      gateway,
      data: formData,
      options: getOptions(),
      onSendProgress: (send, total) {
        onSend(send, total);
      },
    );
    return response;
  }

  Future<diox.Response<dynamic>> postRoute(
    String gateway,
    Map<String, String> body,
  ) async {
    var response = await dio.post(
      gateway,
      data: convert.jsonEncode(body),
    );
    printEndpoint('POST', gateway);
    return response;
  }

  Future<diox.Response<dynamic>> putRoute(
    String gateway,
    Map<String, String> body,
  ) async {
    var response = await dio.put(
      gateway,
      data: convert.jsonEncode(body),
      options: getOptions(),
    );
    printEndpoint('PUT', gateway);
    return response;
  }

  Future<diox.Response<dynamic>> getRoute(String gateway, String params) async {
    var response = await dio.get(
      gateway + params,
      options: getOptions(),
    );
    printEndpoint('GET', gateway);
    printResponse(response);
    return response;
  }

  Future<diox.Response<dynamic>> deleteRoute(
    String gateway,
    Map<String, String> body,
  ) async {
    var response = await dio.delete(
      gateway,
      data: convert.jsonEncode(body),
      options: getOptions(),
    );
    printEndpoint('DELETE', gateway);
    return response;
  }

  diox.Options getOptions() {
    return diox.Options(
      headers: {
        'Authorization': 'Bearer ',
        'Content-Type': 'application/json',
      },
    );
  }

  printEndpoint(String method, String endpoint) {
    print('${method.toUpperCase()}: $endpoint');
  }

  printResponse(diox.Response<dynamic> response) {
    print('StatusCode: ${response.statusCode}');
    print('Body: ${convert.jsonDecode(response.data)}');
  }
}
