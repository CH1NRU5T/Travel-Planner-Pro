import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/home/screens/mobile_home_screen.dart';
import 'package:travel_planner_pro/features/home/screens/web_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: MobileHomeScreen(), web: WebHomeScreen());
  }
}
