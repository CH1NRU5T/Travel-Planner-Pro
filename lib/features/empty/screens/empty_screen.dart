import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
      'assets/lottie/animation2.json',
      fit: BoxFit.cover,
      height: 400,
      width: 400,
    ));
  }
}
