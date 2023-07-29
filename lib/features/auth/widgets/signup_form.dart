import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/auth/widgets/auth_screen_text_button.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';

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

  void signUp(BuildContext context) async {
    context.read<AuthProvider>().signUp(
          name: usernameController.text,
          context: context,
          email: emailController.text,
          password: passwordController.text,
          userName: usernameController.text,
          phone: phoneNumberController.text,
        );
  }

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
        AuthScreenTextButton(
          label: 'Sign Up',
          onPressed: () {
            signUp(context);
          },
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
