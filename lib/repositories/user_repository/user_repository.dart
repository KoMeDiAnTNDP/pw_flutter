import 'package:pw_flutter/helper/models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser({ bool forceUpdate = false }) async {
    if (_user != null && !forceUpdate) return _user;
  }
}
