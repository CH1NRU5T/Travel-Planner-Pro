import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_planner_pro/features/auth/widgets/login_form.dart';
import 'package:travel_planner_pro/features/auth/widgets/signup_form.dart';

class WebAuthScreen extends StatefulWidget {
  const WebAuthScreen({super.key, this.arg = 'login'});
  final String arg;
  @override
  State<WebAuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<WebAuthScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController? confirmPasswordController;
  late TextEditingController? usernameController;
  late TextEditingController? phoneNumberController;
  late bool isLogin;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLogin = widget.arg == 'login' ? true : false;
  }

  void setForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController?.dispose();
    phoneNumberController?.dispose();
    confirmPasswordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usernameController = isLogin ? null : TextEditingController();
    confirmPasswordController = isLogin ? null : TextEditingController();
    phoneNumberController = isLogin ? null : TextEditingController();
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: Lottie.asset('assets/lottie/lottieAnimation.zip'),
          )),
          Expanded(
            child: Form(
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 15),
                child: isLogin
                    ? LoginForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        setForm: setForm,
                      )
                    : SignupForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController!,
                        usernameController: usernameController!,
                        phoneNumberController: phoneNumberController!,
                        setForm: setForm,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
