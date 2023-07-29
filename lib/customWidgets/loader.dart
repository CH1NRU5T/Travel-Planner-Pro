import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({this.loop = false, super.key});
  final bool loop;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/lottieAnimation.zip', repeat: loop);
  }
}
