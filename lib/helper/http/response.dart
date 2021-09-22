import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/types/error_response.dart';

class Response {
  static bool _isUserClass(Map<String, dynamic> json) =>
      json.containsKey('id') && json.containsKey('name')
          && json.containsKey('email') && json.containsKey('balance');

  static bool _isTokenClass(Map<String, dynamic> json) =>
      json.containsKey('id_token');

  static T dataFromJson<T>(Map<String, dynamic> json) {
    if (_isUserClass(json)) {
      return User.fromJSON(json) as T;
    } else if (_isTokenClass(json)) {
      return Token.fromJson(json) as T;
    }
    
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.'
    );
  }
}