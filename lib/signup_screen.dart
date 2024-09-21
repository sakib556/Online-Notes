import 'package:flutter/material.dart';
import 'package:online_notes/global_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Email",
                    hint: "Enter your email",
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Password",
                    hint: "Enter your password",
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GlobalTextField(
                    label: "Confirm Password",
                    hint: "Enter your password again",
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //  Navigator.pop(context);
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
