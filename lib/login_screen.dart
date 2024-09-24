import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/global_text_field.dart';
import 'package:online_notes/signup_screen.dart'; // Import your sign-up screen

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/login_icon.png", height: 200, width: 200),
              SizedBox(height: 20),
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: authController.loginFormKey,
                  child: Column(
                    children: [
                      GlobalTextField(
                        label: "Email",
                        hint: "Enter your email",
                        inputType: InputType.email,
                        textEditingController: emailController,
                      ),
                      SizedBox(height: 10),
                      GlobalTextField(
                        label: "Password",
                        hint: "Enter your password",
                        inputType: InputType.password,
                        textEditingController: passwordController,
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: () {
                            if (authController.loginFormKey.currentState!
                                .validate()) {
                              authController.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          child: authController.isLoginButtonLoading.value
                              ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator())
                              : Text("Login"),
                        );
                      }),
                      SizedBox(height: 20),
                      // Sign-up prompt
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.to(SignupScreen()); // Navigate to sign-up screen
                        },
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
