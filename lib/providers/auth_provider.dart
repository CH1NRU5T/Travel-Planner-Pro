import 'package:flutter/material.dart';
import 'package:travel_planner_pro/features/auth/services/auth_service.dart';
import 'package:travel_planner_pro/features/home/screens/home_screen.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    AuthService authService = AuthService();
    (String?, User?) data = await authService.login(email.trim(), password);
    if (data.$1 == null) {
      user = data.$2;
      notifyListeners();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.$1!)));
      }
    }
  }
}
