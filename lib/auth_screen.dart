import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:online_notes/auth_controller.dart';
import 'package:online_notes/home_screen.dart';
import 'package:online_notes/login_screen.dart';

class AuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _checkUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the auth status
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is logged in
          return HomeScreen();
        } else {
          // User is not logged in
          return LoginScreen();
        }
      },
    );
  }

  Future<User?> _checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
}
