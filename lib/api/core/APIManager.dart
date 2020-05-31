import 'package:flutter/material.dart';
import 'package:sasMovie/api/models/ResponseError.dart';
import 'package:sasMovie/api/core/APIConstants.dart';
import 'package:sasMovie/api/core/CustomException.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class APIManager {
  final String _baseUrl = APIConstants.API_URL;
  var responseJson, response;

  Future<dynamic> get(
      {@required String method,
      Map<String, String> parameters,
      Map<String, String> headers}) async {
    var url = _baseUrl + method + APIConstants.mapToString(parameters);
    try {
      response = await http.get(url, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  ///json data dolu ise postData geçerli sayılmaz!
  Future<dynamic> post({
    @required String method,
    Map<String, String> headers,
    Map<String, String> parameters,
    Map<String, dynamic> postData,
    String jsonData,
  }) async {
    var url = _baseUrl + method + APIConstants.mapToString(parameters);
    var body = jsonData != null ? jsonData : postData;
    try {
      response = await http.post(url, body: body, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    var responseJson = json.decode(response.body.toString());
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 401:
        throw UnauthorisedException(ResponseError.fromJson(responseJson));
      case 404:
        throw BadRequestException(ResponseError.fromJson(responseJson));
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
