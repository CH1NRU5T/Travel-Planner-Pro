import 'package:travel_planner_pro/env/env.dart';
import 'package:travel_planner_pro/features/api/api.dart';

import '../../../models/user_model.dart';

class AuthService {
  Future<(String?, User?)> login(String email, String password) async {
    return await Api.postRequest(
        url: '${Env.baseUrl}/api/v1/signin',
        headers: {'Content-Type': 'application/json'},
        body: {'email': email, 'password': password});
  }
}
