import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/auth/screens/auth_screen.dart';

import '../widgets/landing_screen_text_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const String routeName = '/landing-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-bg1.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(40, 40, 0, 0),
              child: FittedBox(
                child: Text(
                  'Travel Planner Pro',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: CustomColors.yellow),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Escape the tourist traps with unforgettable travel experiences',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.sizeOf(context).shortestSide / 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Travel with us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              MediaQuery.sizeOf(context).shortestSide / 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: LandingScreenTextButton(
                                  label: 'Login',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AuthScreen.routeName,
                                      arguments: 'login',
                                    );
                                  }),
                            ),
                            20.width,
                            Expanded(
                              child: LandingScreenTextButton(
                                  label: 'Sign Up',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AuthScreen.routeName,
                                      arguments: 'signup',
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
