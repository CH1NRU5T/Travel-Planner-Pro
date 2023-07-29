import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_planner_pro/features/auth/widgets/login_form.dart';
import 'package:travel_planner_pro/features/auth/widgets/signup_form.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key, this.arg = 'login'});
  final String arg;
  @override
  State<PhoneAuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<PhoneAuthScreen> {
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
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 15),
          child: isLogin
              ? Column(
                  children: [
                    Expanded(
                      child: Lottie.asset('assets/lottie/lottieAnimation.zip',
                          repeat: false),
                    ),
                    Expanded(
                      flex: 3,
                      child: LoginForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        setForm: setForm,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: Lottie.asset('assets/lottie/lottieAnimation.zip',
                          repeat: false),
                    ),
                    Expanded(
                      flex: 3,
                      child: SignupForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController!,
                        usernameController: usernameController!,
                        phoneNumberController: phoneNumberController!,
                        setForm: setForm,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
