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
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/login_icon.png",
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: authController.signupFormKey, // Apply form key
                  child: Column(
                    children: [
                      GlobalTextField(
                        label: "Name",
                        hint: "Enter your name",
                        inputType: InputType.text,
                        textEditingController: usernameController,
                      ),
                      SizedBox(height: 10),
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
                      GlobalTextField(
                        label: "Confirm Password",
                        hint: "Enter your password again",
                        inputType: InputType.password,
                        textEditingController: confirmPasswordController,
                      ),
                      SizedBox(height: 10),
                      Obx(
                        () => ElevatedButton(
                          onPressed: () {
                            authController.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              cpassword: confirmPasswordController.text,
                              username: usernameController.text,
                            );
                          },
                          child: authController.isSignupButtonLoading.value
                              ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator())
                              : Text("Sign Up"),
                        ),
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
