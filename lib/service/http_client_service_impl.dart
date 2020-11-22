import 'dart:convert';
import 'dart:io';

import 'package:emusic/service/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../exception/auth_exception.dart';
import '../exception/invalid_req_exception.dart';
import '../exception/method_not_allowed_exception.dart';
import '../exception/not_found_exception.dart';
import '../exception/server_error_exception.dart';
import '../exception/unexpected_conflict_exception.dart';
import '../exception/unknown_status_code_exception.dart';

class HttpClientServiceImpl implements HttpClientService {
  String _accessToken = "";

  @override
  set accessToken(token) => _accessToken = token;

  @override
  Future<dynamic> send(
      {@required String method,
      @required String address,
      String host = "49.50.165.208",
      String port = "8096",
      Map<String, dynamic> params = const {},
      Map<String, dynamic> body = const {}}) async {
    String url = 'http://$host:$port$address?';
    print(url);
    params.forEach((key, value) {
      url += '$key=$value&';
    });

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: 'Bearer $_accessToken'
    };

    var response =
        await _getHttpFunction(method, url, headers, jsonEncode(body)).call();

    dynamic responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (e) {
      responseBody = {'err': 'Parse Error'};
    }
    var statusCode = response.statusCode;

    if (statusCode == 200) {
      return responseBody;
    } else {
      String errMsg = responseBody['err'];
      print(errMsg);
      switch (statusCode) {
        case 400:
          return Future.error(InvalidReqException(errMsg));
          break;
        case 401:
          return Future.error(AuthException(errMsg));
          break;
        case 403:
          return Future.error(NotFoundException(errMsg));
          break;
        case 405:
          return Future.error(MethodNotAllowedException(errMsg));
          break;
        case 409:
          return Future.error(UnexpectedConflictException(errMsg));
          break;
        case 500:
          return Future.error(ServerErrorException(errMsg));
          break;
        default:
          return Future.error(UnknownStatusCodeException(errMsg));
          break;
      }
    }
  }

  Function _getHttpFunction(
      String method, String url, Map<String, String> headers, String body) {
    method = method.toUpperCase();
    switch (method) {
      case 'GET':
        return () => http.get(url, headers: headers);
        break;
      case 'POST':
        return () => http.post(url, headers: headers, body: body);
        break;
      case 'PUT':
        return () => http.put(url, headers: headers, body: body);
        break;
      case 'PATCH':
        return () => http.patch(url, headers: headers, body: body);
        break;
      case 'DELETE':
        return () => http.delete(url, headers: headers);
        break;
      default:
        return null;
    }
  }
}
