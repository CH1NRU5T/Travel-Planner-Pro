import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/landing_page/screens/landing_screen_phone.dart';
import 'package:travel_planner_pro/features/landing_page/screens/landing_screen_web.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const String routeName = '/landing-screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: ResponsiveWidget(
            mobile: LandingScreenMobile(), web: LandingScreenWeb()));
  }
}
