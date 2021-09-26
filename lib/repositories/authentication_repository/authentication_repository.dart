import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:pw_flutter/helper/enums/enums.dart';
import 'package:pw_flutter/helper/models/token.dart';
import 'package:pw_flutter/helper/http/http_client.dart';

const Map<String, String> URLS = {
  'SIGN_IN': 'sessions/create',
  'SIGN_UP': 'users',
};

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final HttpClient _httpClient;

  AuthenticationRepository({
    HttpClient? httpClient
  }) : _httpClient = httpClient ?? HttpClient();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  String? _token;

  String? get token => _token;

  Future<void> signIn({required String email, required String password}) async {
    try {
      final responseToken = await _httpClient.makeRequest<Token>(
        Method.POST,
        URLS['SIGN_IN']!,
        body: { 'email': email, 'password': password }
      );
      _token = responseToken.token;
      _httpClient.setToken(_token);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (error) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception(error);
    }
  }

  Future<void> signUp({
    required String email,
    required String name,
    required String password
  }) async {
    try {
      final responseToken = await _httpClient.makeRequest<Token>(
        Method.POST,
        URLS['SIGN_UP']!,
        body: { 'email': email, 'username': name, 'password': password }
      );
      _token = responseToken.token;
      _httpClient.setToken(_token);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (error) {
      _controller.add(AuthenticationStatus.unauthenticated);
      throw Exception(error);
    }
  }

  void logout() {
    _token = null;
    _httpClient.setToken(_token);
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
