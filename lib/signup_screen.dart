import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/global_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthController authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/login_icon.png",
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  GlobalTextField(
                    label: "Name",
                    hint: "Enter your name",
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Email",
                    hint: "Enter your email",
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Password",
                    hint: "Enter your password",
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Confirm Password",
                    hint: "Enter your password again",
                    controller: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        authController.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            cpassword: confirmPasswordController.text,
                            username: usernameController.text);
                      },
                      child: Text("Sign Up"))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
