import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void showSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content), duration: const Duration(seconds: 2),));
  }
}

