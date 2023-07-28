import 'package:flutter/material.dart';

import 'features/auth/screens/auth_screen.dart';

generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
  }
}
