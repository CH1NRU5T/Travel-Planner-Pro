import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Text(authProvider.user!.email);
          },
        ),
      ),
    );
  }
}
