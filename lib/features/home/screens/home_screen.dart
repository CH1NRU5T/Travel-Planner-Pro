import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/colors/custom_colors.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/home/widgets/home_screen_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home-bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            50.height,
            Expanded(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: FittedBox(
                        child: Text(
                      'Travel Planner Pro',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: CustomColors.yellow),
                    )),
                  )),
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
                            TextStyle(fontSize: 30, color: CustomColors.yellow),
                      ),
                    ),
                    20.height,
                    Row(
                      children: [
                        Expanded(
                            child: HomeScreenTextButton(
                          label: 'Login',
                          onPressed: () {
                            Navigator.pushNamed(context, '/auth-screen',
                                arguments: 'login');
                          },
                        )),
                        20.width,
                        Expanded(
                            child: HomeScreenTextButton(
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
