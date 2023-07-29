import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/features/home/screens/home_screen.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';

import 'features/auth/screens/auth_screen.dart';
import 'features/landing_page/screens/landing_screen.dart';
import 'models/user_model.dart';
import 'prefs.dart';

generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthScreen.routeName:
      if (Prefs.getString('token') != null) {
        RouteSettings settings =
            const RouteSettings(name: HomeScreen.routeName);
        return MaterialPageRoute(
            builder: (context) {
              context
                  .read<AuthProvider>()
                  .setUser(User(token: Prefs.getString('token')!).copyWith(
                    token: Prefs.getString('token'),
                  ));
              return const HomeScreen();
            },
            settings: settings);
      }
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
    case LandingScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const LandingScreen(), settings: settings);
    default:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
  }
}
