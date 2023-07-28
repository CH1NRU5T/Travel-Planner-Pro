import 'package:flutter/material.dart';

// bool isWeb() {
//   if (defaultTargetPlatform == TargetPlatform.android ||
//       defaultTargetPlatform == TargetPlatform.iOS) {
//     print('Mobile');
//     return false;
//   }
//   print('Web');
//   return true;
// }

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key, required this.mobile, required this.web});
  final Widget mobile;
  final Widget web;
  @override
  Widget build(BuildContext context) {
    // return isWeb() ? web : mobile;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else {
          return web;
        }
      },
    );
  }
}
