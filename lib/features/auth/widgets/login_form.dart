import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/auth/widgets/auth_screen_text_button.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../customWidgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.setForm});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function setForm;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextFormField(
          controller: emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        20.height,
        CustomTextFormField(
          controller: passwordController,
          label: 'Password',
          isPasswordField: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        20.height,
        AuthScreenTextButton(label: 'Login', onPressed: () {}),
        20.height,
        Center(
          child: RichText(
              text: TextSpan(
            children: [
              const TextSpan(text: 'Don\'t have an account? '),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setForm();
                  },
                text: 'Sign up',
                style: TextStyle(color: CustomColors.yellow),
              ),
            ],
          )),
        )
      ],
    );
  }
}
