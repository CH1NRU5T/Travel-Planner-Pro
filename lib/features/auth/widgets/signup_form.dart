import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../customWidgets/custom_text_form_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.usernameController,
      required this.phoneNumberController,
      required this.setForm});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController usernameController;
  final TextEditingController phoneNumberController;
  final Function setForm;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFormField(
          controller: usernameController,
          label: 'Username',
        ),
        20.height,
        CustomTextFormField(
          controller: emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        20.height,
        CustomTextFormField(
          controller: phoneNumberController,
          label: 'Phone Number',
          keyboardType: TextInputType.phone,
        ),
        20.height,
        CustomTextFormField(
          controller: passwordController,
          label: 'Password',
          isPasswordField: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        20.height,
        CustomTextFormField(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          isPasswordField: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        20.height,
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
              backgroundColor: CustomColors.yellow,
              padding: const EdgeInsets.all(20)),
          child: const Text('Sign up'),
        ),
        20.height,
        Center(
          child: RichText(
              text: TextSpan(
            children: [
              const TextSpan(text: 'Already have an account? '),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setForm();
                  },
                text: 'Login',
                style: TextStyle(color: CustomColors.yellow),
              ),
            ],
          )),
        )
      ],
    );
  }
}
