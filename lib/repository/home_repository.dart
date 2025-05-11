import 'package:flutter_common/models/index.dart';
import 'package:jaksim_one_month/core/network/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository {
  Future<User> getOrCreateUserInfo();
}

class HomeDefaultRepository extends HomeRepository {
  static const String userIdKey = 'jaksim_one_month_user_id';
  final SharedPreferences prefs;
  final DioClient _dioClient;

  HomeDefaultRepository({required this.prefs}) : _dioClient = DioClient();

  @override
  Future<User> getOrCreateUserInfo() async {
    final userId = prefs.getString(userIdKey);

    if (userId == null) {
      final response = await _dioClient.post('/user', data: {
        'username': null,
        'email': null,
        'password': DateTime.now().toIso8601String(),
        'type': 'JAKSIM',
      });

      prefs.setString(userIdKey, response.data['id']);

      return User.fromJson(response.data);
    }
    final response = await _dioClient.get('/user/$userId');

    return User.fromJson(response.data);
  }
}
