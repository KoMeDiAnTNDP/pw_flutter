import 'package:pw_flutter/helper/enums/enums.dart';
import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/http/http_client.dart';

const Map<String, String> URLS = {
  'GET_USER': 'api/protected/user-info',
  'FILTERED_USERS': 'api/protected/users/list',
};

class UserRepository {
  User? _user;
  final HttpClient _httpClient = HttpClient();

  UserRepository();

  Future<User> getUser({ bool forceUpdate = false }) async {
    if (_user != null && !forceUpdate) return _user!;
    
    try {
      final user = await _httpClient.makeRequest<User>(
        Method.GET,
        URLS['GET_USER']!
      );
      _user = user;

      return _user!;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<FilteredUser>> getFilteredUsers(String name) async {
    try {
      final filteredUsers = await _httpClient.makeRequest<List<FilteredUser>>(
        Method.POST,
        URLS['FILTERED_USERS']!,
        body: { 'filter': name },
      );

      return filteredUsers;
    } catch (error) {
      throw Exception(error);
    }
  }
}
