import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/auth/widgets/auth_screen_text_button.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../customWidgets/custom_text_form_field.dart';
import '../../../providers/auth_provider.dart';

class LoginForm extends StatelessWidget {
  void login(BuildContext context) async {
    context.read<AuthProvider>().login(
        email: emailController.text.trim(),
        password: passwordController.text,
        context: context);
  }

  const LoginForm(
      {super.key,
      this.isWeb = false,
      required this.emailController,
      required this.passwordController,
      required this.setForm});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function setForm;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        15.height,
        CustomTextFormField(
          controller: emailController,
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        15.height,
        CustomTextFormField(
          controller: passwordController,
          label: 'Password',
          isPasswordField: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        15.height,
        AuthScreenTextButton(
            label: 'Login',
            onPressed: () {
              login(context);
            }),
        15.height,
        Center(
          child: RichText(
              text: TextSpan(
            style: const TextStyle(fontSize: 19),
            children: [
              TextSpan(
                  text: 'Don\'t have an account? ',
                  style: TextStyle(color: isWeb ? Colors.white : Colors.black)),
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
