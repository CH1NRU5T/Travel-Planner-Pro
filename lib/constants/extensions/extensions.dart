import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension Toast on BuildContext {
  void showToast({required String msg}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
