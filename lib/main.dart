import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/env/env.dart';
import 'package:travel_planner_pro/features/landing_page/screens/landing_screen.dart';
import 'package:travel_planner_pro/prefs.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';
import 'package:travel_planner_pro/providers/destination_provider.dart';
import 'package:travel_planner_pro/providers/map_provider.dart';
import 'package:travel_planner_pro/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DestinationProvider(),
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
    html.ScriptElement script = html.ScriptElement()
      ..src =
          'https://maps.googleapis.com/maps/api/js?key=${Env.key}&libraries=libraries=drawing,visualization,places';
    html.querySelector('#customScript')!.replaceWith(script);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
