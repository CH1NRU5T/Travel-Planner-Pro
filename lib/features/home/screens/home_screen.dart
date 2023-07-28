import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Travel Planner Pro'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Login'),
          )
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Center(
              child: LottieBuilder.asset('assets/lottie/home-bg.zip',
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: MediaQuery.sizeOf(context).height * 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
