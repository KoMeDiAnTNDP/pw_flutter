import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pw_flutter/helper/enums/enums.dart';

import 'package:pw_flutter/helper/http/response.dart';

const BASE_URL = 'http://193.124.114.46:3001/';

class HttpClient {
  final client = http.Client();

  HttpClient._internal();

  static final _singleton = HttpClient._internal();

  factory HttpClient() => _singleton;

  String? _token;

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
  }

  Future<T> makeRequest<T>(
      Method method,
      String url, {
        Map<String, dynamic>? params,
        Object? body
      }) async {
    final T data;

    switch (method) {
      case Method.GET:
        try {
          final query = Uri(queryParameters: params).query;
          final Uri uri = Uri.parse('$BASE_URL$url?$query');
          data = await _get<T>(uri);
        } catch (err) {
          throw Exception(err);
        }
        break;
      case Method.POST:
        final Uri uri = Uri.parse('$BASE_URL$url');
        data = await _post<T>(uri, body);
        break;
    }

    return data;
  }

  Future<T> _post<T>(Uri uri, Object? data) async {
    final Map<String, String> headers = {
      "Accept": 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    try {
      final body = jsonEncode(data);
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode != 400 || response.statusCode != 401) {
        return Response.dataFromJson<T>(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<T> _get<T>(Uri uri) async {
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return Response.dataFromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}