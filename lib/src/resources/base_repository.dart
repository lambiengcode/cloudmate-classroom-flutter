import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:dio/dio.dart' as diox;
import 'dart:convert' as convert;
import 'dart:async';

class BaseRepository {
  var dio = diox.Dio(diox.BaseOptions(
    baseUrl: Application.baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 20000,
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
    diox.FormData formData, {
    Function? callBack,
  }) async {
    var response = await dio.post(
      gateway,
      data: formData,
      options: getOptions(),
      onSendProgress: (send, total) {
        if (callBack != null) {
          callBack(send, total);
        }
      },
    );
    return response;
  }

  Future<diox.Response<dynamic>> postRoute(
      String gateway, Map<String, dynamic> body,
      {String? query, String? token}) async {
    printEndpoint('POST', gateway);

    Map<String, String> paramsObject = {};
    if (query != null) {
      query.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }
    var response = await dio.post(
      gateway,
      data: convert.jsonEncode(body),
      options: getOptions(token: token),
      queryParameters: query == null ? null : paramsObject,
    );
    printResponse(response);
    return response;
  }

  Future<diox.Response<dynamic>> putRoute(
      String gateway, Map<String, dynamic> body,
      {String? token}) async {
    printEndpoint('PUT', gateway);
    var response = await dio.put(
      gateway,
      data: convert.jsonEncode(body),
      options: getOptions(token: token),
    );
    return response;
  }

  Future<diox.Response<dynamic>> patchRoute(
    String gateway, {
    String? query,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    printEndpoint('PATCH', gateway);
    Map<String, String> paramsObject = {};
    if (query != null) {
      query.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }

    var response = await dio.patch(
      gateway,
      data: convert.jsonEncode(body),
      options: getOptions(token: token),
      queryParameters: query == null ? null : paramsObject,
    );
    return response;
  }

  Future<diox.Response<dynamic>> getRoute(
    String gateway, {
    String? params,
    String? query,
    String? token,
  }) async {
    printEndpoint('GET', gateway);
    Map<String, String> paramsObject = {};
    if (query != null) {
      query.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }

    var response = await dio.get(
      gateway + (params ?? ''),
      options: getOptions(token: token),
      queryParameters: query == null ? null : paramsObject,
    );
    // printResponse(response);
    return response;
  }

  Future<diox.Response<dynamic>> deleteRoute(
    String gateway, {
    String? params,
    String? query,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    printEndpoint('DELETE', gateway);
    Map<String, String> paramsObject = {};
    if (query != null) {
      query.split('&').forEach((element) {
        paramsObject[element.split('=')[0].toString()] =
            element.split('=')[1].toString();
      });
    }

    var response = await dio.delete(
      gateway + (params ?? ''),
      options: getOptions(token: token),
      queryParameters: query == null ? null : paramsObject,
      data: body == null ? null : convert.jsonEncode(body),
    );
    return response;
  }

  diox.Options getOptions({String? token}) {
    return diox.Options(
      validateStatus: (status) => true,
      headers: getHeaders(token: token),
    );
  }

  getHeaders({String? token}) {
    return {
      'Authorization': 'Bearer ' + (token ?? UserLocal().getAccessToken()),
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
    };
  }

  printEndpoint(String method, String endpoint) {
    // print('${method.toUpperCase()}: ${Application.baseUrl}$endpoint');
  }

  printResponse(diox.Response<dynamic> response) {
    // print('StatusCode: ${response.statusCode}');
    // print('Body: ${response.data.toString()}');
  }
}
