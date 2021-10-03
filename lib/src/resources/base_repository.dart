import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:dio/dio.dart' as diox;
import 'dart:convert' as convert;
import 'dart:async';

import 'package:cloudmate/src/configs/application.dart';

class BaseRepository {
  var dio = diox.Dio(diox.BaseOptions(
    baseUrl: Application.baseUrl!,
    connectTimeout: 10000,
    receiveTimeout: 10000,
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
      options: getOptions(),
    );
    printEndpoint('POST', gateway);
    printResponse(response);
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

  Future<diox.Response<dynamic>> getRoute(
    String gateway, {
    String? params,
    String? query,
  }) async {
    Map<String, String> paramsObject = {};
    if (params != null) {
      params.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }

    var response = await dio.get(
      gateway + (params ?? ''),
      options: getOptions(),
      queryParameters: query == null ? null : paramsObject,
    );
    printEndpoint('GET', gateway);
    // printResponse(response);
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
      validateStatus: (status) => true,
      headers: {
        'Authorization': 'Bearer ' + UserLocal().getAccessToken(),
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
  }

  printEndpoint(String method, String endpoint) {
    print('${method.toUpperCase()}: $endpoint');
  }

  printResponse(diox.Response<dynamic> response) {
    print('StatusCode: ${response.statusCode}');
    print('Body: ${response.data.toString()}');
  }
}
