import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/login_controller.dart';
import 'package:test/routes/route_name.dart';

import '../widgets/loading_overlay.dart';
import '../widgets/snackbar_error.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginControler = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // text login
            Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            // text sub
            const Text(
              'Lets login to contact app',
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // textfield username
            TextField(
              controller: loginControler.emailController,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Username',
                labelText: 'Username',
                floatingLabelStyle: const TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // textfield password
            TextField(
              controller: loginControler.passwordController,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Password',
                labelText: 'Password',
                floatingLabelStyle: const TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            // button signin
            ElevatedButton(
              onPressed: () async {
                LoadingOverlay.show(message: 'Login...');
                try {
                  await loginControler.login();
                  Get.offAllNamed(RouteName.homePage);
                } catch (e) {
                  LoadingOverlay.hide();
                  snackbarError(e);
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: Colors.blue.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
