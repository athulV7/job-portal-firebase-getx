import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign_in_controller.dart';

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required this.signInController,
    required this.height,
    required this.width,
  }) : super(key: key);

  final SignInController signInController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: onSignInButtonClicked,
          child: Container(
            height: height * 0.056,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.07,
        ),
        const Center(
          child: Text('OR'),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        GestureDetector(
          onTap: () async {
            await signInController.googleLogIn();
            String userUID = FirebaseAuth.instance.currentUser!.uid;
            String userEmail = FirebaseAuth.instance.currentUser!.email!;
            var docRef =
                FirebaseFirestore.instance.collection('Users').doc(userUID);
            var docSnapshot = await docRef.get();
            if (!docSnapshot.exists) {
              docRef.set({
                'Auth': {'email': userEmail}
              });
            }
          },
          child: Container(
            height: height * 0.056,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 230, 230),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: width * 0.07,
                      width: width * 0.07,
                      child: const Image(
                        image: AssetImage(
                          'assets/images/googlelogo.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    const Text(
                      'Connect with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onSignInButtonClicked() async {
    if (signInController.formKey.currentState!.validate()) {
      log("sign in Validation succesful");
      var collectionRefrnce =
          await FirebaseFirestore.instance.collection("Users").get();

      //---------------checking user email is exist or not------------
      var matchingUsers = collectionRefrnce.docs
          .where((element) =>
              element.data()['Auth']['email'] ==
              signInController.emailController.text)
          .toList();
      if (matchingUsers.isNotEmpty) {
        log('user exists');
        if (matchingUsers.first.data()['Auth']['password'] ==
            signInController.passwordController.text) {
          signInController.signIn();
          log('sign in success');
          signInController.emailController.clear();
          signInController.passwordController.clear();
        } else {
          Get.snackbar(
            'Error',
            'password does not match',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        log("usernotfound");
        Get.snackbar(
          'Error',
          'User not exist. please sign in ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      log("sign in button execution complete");
    }
  }
}
