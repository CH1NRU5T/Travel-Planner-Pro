import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/features/landing_page/screens/landing_screen.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';
import 'package:travel_planner_pro/router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LandingScreen(),
      onGenerateRoute: (settings) {
        return generateRoute(settings);
      },
    );
  }
}
