import 'package:flutter/material.dart';
import 'package:travel_planner_pro/features/error_404/screens/error_404_screen.dart';
import 'package:travel_planner_pro/features/home/screens/home_screen.dart';
import 'package:travel_planner_pro/features/itinerary/screens/itinerary_screen.dart';
import 'package:travel_planner_pro/prefs.dart';

import 'features/auth/screens/auth_screen.dart';
import 'features/landing_page/screens/landing_screen.dart';

generateRoute(RouteSettings settings) {
  if (settings.name != null) {
    var uriData = Uri.parse(settings.name!);
    switch (uriData.path) {
      case AuthScreen.routeName:
        if (Prefs.getString('token') != null) {
          return MaterialPageRoute(
              builder: (_) => const HomeScreen(), settings: settings);
        }
        if (settings.arguments == null) {
          RouteSettings settings = const RouteSettings(
              name: AuthScreen.routeName, arguments: 'login');
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
      case ItineraryScreen.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                ItineraryScreen(itid: uriData.queryParameters['itid']!),
            settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const Error404Screen());
    }
  }
}
