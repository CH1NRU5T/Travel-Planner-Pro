import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/auth/screens/phone_auth_screen.dart';
import 'package:travel_planner_pro/features/auth/screens/web_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: PhoneAuthScreen(),
      web: WebAuthScreen(),
    );
  }
}
