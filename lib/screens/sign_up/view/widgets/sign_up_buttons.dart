import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';
import 'package:job_portal/screens/sign_up/controller/sign_up_controller.dart';

final formKeyUp = GlobalKey<FormState>();

class SignUpOptionButtons extends StatelessWidget {
  SignUpOptionButtons({super.key});

  final signInController = Get.put(SignInController());

  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;
    final height = Get.size.height;
    return Wrap(
      children: [
        GestureDetector(
          onTap: onSignUpButtonClicked,
          child: Container(
            height: height * 0.056,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white),
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
          onTap: () {
            signInController.googleLogIn();
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
        SizedBox(
          height: height * 0.1,
        ),
      ],
    );
  }

  void onSignUpButtonClicked() async {
    if (formKeyUp.currentState!.validate()) {
      //checking the user email is already exist in the collection
      var collectionRef =
          await FirebaseFirestore.instance.collection("Users").get();
      if (collectionRef.docs
          .where(
            (element) =>
                element.data()['Auth']['email'].toString() ==
                signUpController.emailController.text,
          )
          .isEmpty) {
        //sign up
        await signUpController.signUp();

        //add user details to firebase users collection
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'Auth': {
            'email': signUpController.emailController.text,
            'password': signUpController.passwordController.text,
          },
        });

        signUpController.emailController.clear();
        signUpController.passwordController.clear();
        signUpController.confirmPasswordController.clear();
      } else {
        Get.snackbar(
          'Email',
          'This user is already exist',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
