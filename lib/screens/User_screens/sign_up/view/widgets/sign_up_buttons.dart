import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpOptionButtons extends StatelessWidget {
  const SignUpOptionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Get.size.width;
    final height = Get.size.height;
    return Wrap(
      children: [
        GestureDetector(
          // onTap: () {
          //   if (GetUtils.isEmail(
          //       signInController.emailController.text)) {
          //     print('object');
          //   } else {
          //     Get.snackbar('title', 'sdhfkjskjdfh');
          //   }
          // },
          child: Container(
            height: height * 0.056,
            width: width * 0.9,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Text(
                'Send OTP',
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
        Container(
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
        SizedBox(
          height: height * 0.1,
        ),
      ],
    );
  }
}
