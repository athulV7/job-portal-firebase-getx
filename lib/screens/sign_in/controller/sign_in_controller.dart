import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_portal/screens/Main_screen/main_screen.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  //Google SignIn ---
  Future googleLogIn() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAll(const MainScreen());
  }

  //Goolge SignOut
  Future googleSignOut() async {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }

  //SignIn with Email and Password
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  bool obscureText = true;
  Icon visibilityIcon = const Icon(
    Icons.visibility_off,
    color: Colors.black,
  );

  void visibility() {
    if (obscureText == false) {
      visibilityIcon = const Icon(
        Icons.visibility_off,
        color: Colors.black,
      );
      obscureText = true;
      update();
    } else {
      visibilityIcon = const Icon(
        Icons.visibility,
        color: Colors.black,
      );
      obscureText = false;
      update();
    }
  }
}
