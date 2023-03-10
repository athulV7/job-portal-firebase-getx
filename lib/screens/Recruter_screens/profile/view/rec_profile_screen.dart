import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';

import '../../../Main_screen/main_screen.dart';

class RecProfileScreen extends StatelessWidget {
  RecProfileScreen({super.key});

  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await signInController.googleSignOut();
              Get.offAll(const MainScreen());
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUserID)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            var userProfileRef = snapshot.data!.data()!['profile'];
            RecruiterProfileModel recruiterProfileModel =
                RecruiterProfileModel.fromJson(userProfileRef);
            return Padding(
              padding: EdgeInsets.only(
                right: width * 0.03,
                left: width * 0.03,
                //bottom: width * 0.03,
                top: width * 0.08,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.2,
                        margin: EdgeInsets.only(top: width * 0.19),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.cyan.withOpacity(0.1),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: width * 0.18),
                              child: Text(
                                recruiterProfileModel.companyName,
                                style: subHeadingNormal,
                              ),
                            ),
                            SizedBox(
                              height: width * 0.07,
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/images/Screenshot 2023-03-06 113206.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: height * 0.3,
                      margin: EdgeInsets.only(top: width * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        color: Colors.cyan.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: height * 0.08,
                            margin: EdgeInsets.all(width * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: height * 0.08,
                              margin: EdgeInsets.only(
                                left: width * 0.02,
                                right: width * 0.02,
                                //bottom: width * 0.02,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
