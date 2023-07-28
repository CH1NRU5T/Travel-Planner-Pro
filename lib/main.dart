import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/features/auth/screens/auth_screen.dart';
import 'package:travel_planner_pro/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.yellow),
        useMaterial3: true,
      ),
      initialRoute: AuthScreen.routeName,
      home: const AuthScreen(),
      onGenerateRoute: (settings) {
        return generateRoute(settings);
      },
    );
  }
}
