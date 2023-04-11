import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Main_screen/main_screen.dart';
import 'package:job_portal/screens/User_screens/home/view/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.offAll(const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.08),
          LottieBuilder.asset(
            "assets/lottie/48428-working.json",
          ),
          SizedBox(height: height * 0.08),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image(
              image: const AssetImage("assets/images/hireBridgelogo.jpeg"),
              height: width * 0.12,
              width: width * 0.12,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: height * 0.01),
          // SizedBox(
          //   height: height * 0.12,
          //   width: width * 1,
          //   child: Image(
          //       image: AssetImage(
          //           "assets/images/_get_premium_download_high_resolution_imagedesigned_with_EDIT.org.jpg")),
          // )
          Text(
            "Hire Bridge",
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.bold,
              fontSize: 33,
              color: const Color.fromARGB(255, 7, 175, 241),
            ),
          ),
        ],
      ),
    );
  }
}
