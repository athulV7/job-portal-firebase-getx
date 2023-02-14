import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';
import 'package:job_portal/screens/sign_up/view/sign_up.dart';

import 'widgets/sign_in_buttons.dart';
import 'widgets/textformfields_widgets.dart';

class SignIn extends GetView<SignInController> {
  SignIn({super.key});

  final formKey = GlobalKey<FormState>();
  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;
    final height = Get.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(height * 0.02),
        child: GetBuilder<SignInController>(
          builder: (controller) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.07),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),

                    //textfields for login/password
                    SignInTextfieldsWidget(signInController: signInController),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('forgot password?'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),

                    //sign in buttons
                    SignInButtons(
                      signInController: signInController,
                      height: height,
                      width: width,
                    ),

                    SizedBox(
                      height: height * 0.055,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Don't have any account?"),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: SizedBox(width: width * 0.02),
                          ),
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(SignUpScreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
