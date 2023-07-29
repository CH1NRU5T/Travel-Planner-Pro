import 'package:flutter/material.dart';
import 'package:travel_planner_pro/features/auth/services/auth_service.dart';
import 'package:travel_planner_pro/features/home/screens/home_screen.dart';
import 'package:travel_planner_pro/prefs.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService = AuthService();

  void clearUser(BuildContext context) {
    Prefs.remove('token');
    Navigator.pop(context);
    notifyListeners();
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    (String?, User?) data = await authService.login(email.trim(), password);
    if (data.$1 == null) {
      Prefs.setString('token', data.$2!.token);
      notifyListeners();
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.$1!)));
      }
    }
  }

  void signUp(
      {required String userName,
      required String name,
      required String email,
      required String phone,
      required String password,
      required BuildContext context}) async {
    (String?, User?) data = await authService.signUp(
      userName: userName,
      email: email,
      password: password,
      phone: phone,
      name: name,
    );
    if (data.$1 == null) {
      Prefs.setString('token', data.$2!.token);

      notifyListeners();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data.$1!),
          ),
        );
      }
    }
  }
}
