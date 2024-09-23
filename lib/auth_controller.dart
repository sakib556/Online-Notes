import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_notes/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_notes/login_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isLoginButtonLoading = false.obs;
  var isSignupButtonLoading = false.obs;
  var isLoggedIn = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  // Login
  Future<void> login({required String email, required String password}) async {
    try {
      isLoginButtonLoading.value = true;
      if (loginFormKey.currentState!.validate()) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        Get.off(HomeScreen());
      } else {
        showErrorDialog("Please enter valid email and password.");
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } finally {
      isLoginButtonLoading.value = false; // Ensure loading state is reset
    }
  }

// Add this line at the top of your file to import Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Sign Up
  Future<void> signUp({
    required String email,
    required String password,
    required String cpassword,
    required String username,
  }) async {
    try {
      isSignupButtonLoading.value = true;
      if (signupFormKey.currentState!.validate()) {
        if (password != cpassword) {
          showErrorDialog("Passwords do not match.");
          return;
        }

        // Create user in Firebase Auth
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Create a new document in Firestore
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
          'createdAt':
              FieldValue.serverTimestamp(), // Sets the timestamp in Firestore
        });

        Get.back(); // Navigate back after successful sign-up
      } else {
        showErrorDialog("Please enter valid email and password.");
      }
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    } finally {
      isSignupButtonLoading.value = false; // Ensure loading state is reset
    }
  }

  void showErrorDialog(String errorMessage) {
    Get.defaultDialog(
      title: 'Error',
      content: Column(
        children: [
          Icon(Icons.error, color: Colors.red, size: 50),
          SizedBox(height: 10),
          Text(errorMessage, textAlign: TextAlign.center),
        ],
      ),
      textConfirm: 'OK',
      onConfirm: () {
        Get.back(); // Closes the dialog
      },
    );
  }

  void handleFirebaseAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'email-already-in-use':
        message = 'The email address is already in use by another account.';
        break;
      default:
        message = 'An unknown error occurred.';
    }
    showErrorDialog(message);
  }

  // Logout
  void logout() {
    auth.signOut();
    isLoggedIn.value = false;
    Get.off(LoginScreen());
  }

  User? get currentUser => auth.currentUser;
}
