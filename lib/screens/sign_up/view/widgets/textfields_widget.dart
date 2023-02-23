import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/sign_up/controller/sign_up_controller.dart';
import 'package:job_portal/screens/sign_up/view/widgets/sign_up_buttons.dart';

class TextformFieldWidget extends StatelessWidget {
  TextformFieldWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyUp,
      child: Column(
        children: [
          TextFormField(
            controller: signUpController.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
                return "Enter a valid Email";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.black,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          TextFormField(
            controller: signUpController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: signUpController.obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a password';
              } else if (value.length < 8) {
                return 'Password must be contain atleast 8 characters';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  signUpController.visibility();
                },
                icon: signUpController.visibilityIcon,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.025,
          ),
          TextFormField(
            controller: signUpController.confirmPasswordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: signUpController.obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Re-enter the password';
              } else if (value != signUpController.passwordController.text) {
                return 'Password does not match';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  signUpController.visibility();
                },
                icon: signUpController.visibilityIcon,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
