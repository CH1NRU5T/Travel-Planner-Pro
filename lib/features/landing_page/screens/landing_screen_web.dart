import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../auth/screens/auth_screen.dart';
import '../widgets/landing_screen_text_button.dart';

class LandingScreenWeb extends StatelessWidget {
  const LandingScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(1),
        image: const DecorationImage(
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
                    fontSize: 50,
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
                      fontWeight: FontWeight.bold,
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
                        fontSize: MediaQuery.sizeOf(context).shortestSide / 15,
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
                                    // '${ItineraryScreen.routeName}?itid=1qw'
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
    );
  }
}
