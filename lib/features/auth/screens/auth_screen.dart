import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/auth/screens/phone_auth_screen.dart';
import 'package:travel_planner_pro/features/auth/screens/web_auth_screen.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String arg = ModalRoute.of(context)!.settings.arguments as String;

    return ResponsiveWidget(
      mobile: PhoneAuthScreen(
        arg: arg,
      ),
      web: WebAuthScreen(arg: arg),
    );
  }
}
