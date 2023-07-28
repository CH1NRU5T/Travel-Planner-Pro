import 'package:flutter/material.dart';

import '../../../constants/colors/custom_colors.dart';

class AuthScreenTextButton extends StatelessWidget {
  const AuthScreenTextButton(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed,
      style: TextButton.styleFrom(
          backgroundColor: CustomColors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20)),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
