import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final width = Get.size.width;
final height = Get.size.height;

final subHeadlineStyle = GoogleFonts.robotoSlab(
  textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
);

const subHeadingNormal = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

const thirdTextStyle = TextStyle(
  color: Colors.cyan,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

//common textformfield input decoration
InputDecoration textfieldInputDecoration(String label, bool alignLabel) {
  return InputDecoration(
    labelText: label,
    alignLabelWithHint: alignLabel,
    labelStyle: const TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white70,
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
  );
}
