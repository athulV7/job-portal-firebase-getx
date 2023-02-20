import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/screens/User_screens/sign_in/view/sign_in.dart';
import 'package:job_portal/screens/User_screens/sign_up/controller/sign_up_controller.dart';
import 'package:job_portal/screens/User_screens/sign_up/view/widgets/sign_up_buttons.dart';

import 'widgets/textfields_widget.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({super.key});

  //final signUpController = Get.put(SignInController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;
    final height = Get.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Getting Started',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Create an account to continue",
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.055,
                  ),

                  //creating textform fields
                  TextformFieldWidget(height: height),

                  SizedBox(
                    height: height * 0.035,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'By creating an account, you agree to our '),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),

                  //sign up buttons
                  const SignUpOptionButtons(),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Already have an account?"),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(width: width * 0.02),
                          ),
                          TextSpan(
                            text: "Sign In",
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(SignIn());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
