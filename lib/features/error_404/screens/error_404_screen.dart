import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({super.key});
  static const routeName = '/error404';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('assets/lottie/animation1.json'),
    );
  }
}
