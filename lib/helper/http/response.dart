import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/types/error_response.dart';

class Response {
  static bool _isUserClass(Map<String, dynamic> json) =>
      json['user_info_token'] != null
          && json['user_info_token'].containsKey('id')
          && json['user_info_token'].containsKey('name')
          && json['user_info_token'].containsKey('email')
          && json['user_info_token'].containsKey('balance');

  static bool _isTokenClass(Map<String, dynamic> json) =>
      json.containsKey('id_token');

  static bool _isFilteredUser(Map<String, dynamic> json) =>
      json.containsKey('id') && json.containsKey('name');

  static T dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic>) {
      if (_isUserClass(json)) {
        return User.fromJSON(json['user_info_token']) as T;
      } else if (_isTokenClass(json)) {
        return Token.fromJson(json) as T;
      }
    } else if (json is List<Map<String, dynamic>>) {
      if (json.isEmpty) {
        return List.empty() as T;
      } else {
        if (json.any((element) => _isFilteredUser(element))) {
          return json.map((element) => FilteredUser.fromJson(element))
            .toList() as T;
        }
      }
    }
    
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.'
    );
  }
}