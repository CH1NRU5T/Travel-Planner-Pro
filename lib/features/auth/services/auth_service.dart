import 'package:travel_planner_pro/env/env.dart';
import 'package:travel_planner_pro/features/api/api.dart';

import '../../../models/user_model.dart';

class AuthService {
  Future<(String?, dynamic)> login(String email, String password) async {
    return await Api.postRequest(
        url: '${Env.baseUrl}/api/v1/signin',
        headers: {'Content-Type': 'application/json'},
        body: {'email': email, 'password': password});
  }

  Future<(String?, User?)> signUp({
    required String email,
    required String userName,
    required String name,
    required String phone,
    required String password,
  }) async {
    return await Api.postRequest(url: '${Env.baseUrl}/api/v1/signup', headers: {
      'Content-Type': 'application/json'
    }, body: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'userName': userName
    }) as (String?, User?);
  }
}
