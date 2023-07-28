import 'package:flutter/material.dart';

import 'features/auth/screens/auth_screen.dart';
import 'features/home/screens/home_screen.dart';

generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      if (settings.arguments == null) {
        RouteSettings settings =
            const RouteSettings(name: AuthScreen.routeName, arguments: 'login');
        return MaterialPageRoute(
            builder: (_) => const AuthScreen(), settings: settings);
      }
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: settings);
    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const HomeScreen(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
  }
}
