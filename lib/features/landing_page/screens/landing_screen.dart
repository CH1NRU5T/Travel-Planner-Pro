import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/landing_page/widgets/landing_screen_text_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  static const String routeName = '/landing-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        child: Row(
          children: [
            50.height,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 50, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
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
                    60.height,
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'Escape the tourist traps with unforgettable travel experiences',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(MediaQuery.sizeOf(context).width / 15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Travel with us',
                        style:
                            TextStyle(fontSize: 50, color: CustomColors.yellow),
                      ),
                    ),
                    20.height,
                    Row(
                      children: [
                        Expanded(
                            child: LandingScreenTextButton(
                          label: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth-screen',
                                arguments: 'login');
                          },
                        )),
                        20.width,
                        Expanded(
                            child: LandingScreenTextButton(
                          label: 'Sign Up',
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth-screen',
                                arguments: 'signup');
                          },
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
