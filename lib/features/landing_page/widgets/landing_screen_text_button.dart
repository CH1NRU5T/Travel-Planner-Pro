import 'package:flutter/material.dart';

import '../../../constants/colors/custom_colors.dart';

class LandingScreenTextButton extends StatelessWidget {
  const LandingScreenTextButton(
      {super.key, required this.onPressed, required this.label});
  final Function onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.all(20),
        backgroundColor: CustomColors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
