import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/sign_in_controller.dart';

class SignInTextfieldsWidget extends StatelessWidget {
  const SignInTextfieldsWidget({
    Key? key,
    required this.signInController,
    required this.formKey,
  }) : super(key: key);

  final SignInController signInController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final height = Get.size.height;
    return Form(
      key: formKey,
      child: Wrap(
        children: [
          TextFormField(
            controller: signInController.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Email';
              } else if (!GetUtils.isEmail(value)) {
                return 'Enter a valid Email';
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
            height: height * 0.09,
          ),
          TextFormField(
            controller: signInController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: signInController.obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the password';
              } else {
                return null;
              }
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
                  signInController.visibility();
                },
                icon: signInController.visibilityIcon,
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
            height: height * 0.009,
          ),
        ],
      ),
    );
  }
}
