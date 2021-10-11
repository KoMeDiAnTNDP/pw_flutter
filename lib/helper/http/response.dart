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

  static bool _isTransactionData(Map<String, dynamic> json) =>
      json.containsKey('trans_token');

  static bool _isTransaction(Map<String, dynamic> json) =>
      json.containsKey('trans_token')
          && json['trans_token'].containsKey('id')
          && json['trans_token'].containsKey('date')
          && json['trans_token'].containsKey('username')
          && json['trans_token'].containsKey('amount')
          && json['trans_token'].containsKey('balance');

  static bool _isTransactionList(Map<String, dynamic> json) =>
      json.containsKey('trans_token') && json['trans_token'] is List<dynamic>;

  static T dataFromJson<T>(Object json) {
    if (json is Map<String, dynamic>) {
      if (_isUserClass(json)) {
        return User.fromJSON(json['user_info_token']) as T;
      } else if (_isTokenClass(json)) {
        return Token.fromJson(json) as T;
      } else if (_isTransactionList(json)) {
        final transactionsJsonList = json['trans_token'] as List;

        if (transactionsJsonList.isEmpty) {
          return List.empty() as T;
        } else {
          return transactionsJsonList
              .map((element) => Transaction.fromJson(element)).toList() as T;
        }
      } else if (_isTransaction(json)) {
        return Transaction.fromJson(json['trans_token']) as T;
      }
    } else if (json is List) {
      if (json.isEmpty) {
        return <FilteredUser>[] as T;
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