import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    try {
      // Call the login API service
      // Replace AuthService() with the actual instance of your API service
      var result = await AuthService().login(email, password);

      // Handle the result (you may want to check for success, error, etc.)
      log('login successfully : response -> $result');
    } catch (e) {
      throw e.toString();
    }
  }
}
