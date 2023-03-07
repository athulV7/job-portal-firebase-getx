import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Role_select_screen/controller/role_controller.dart';
import 'package:job_portal/screens/profile_setting_screen/view/recriter_profile_screen.dart';
import 'package:job_portal/screens/profile_setting_screen/view/seeker_profile_screen.dart';
import 'package:lottie/lottie.dart';

class RoleSelectionScreen extends StatelessWidget {
  RoleSelectionScreen({super.key});

  final roleController = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.12),
        child: Column(
          children: [
            LottieBuilder.asset(
              'assets/lottie/100618-career.json',
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Icon(
              Icons.person_pin_rounded,
              color: Colors.grey.shade800,
              size: 28,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            const Text(
              'What are you looking for?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            GetBuilder<RoleController>(
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      roleController.seekerButtonTap();
                    },
                    child: JobRoleButtonWidget(
                      icon: Icons.hail,
                      text: 'I want a Job',
                      elevation: roleController.elevation1,
                      visibility: roleController.checkVisibility1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      roleController.recruterButtonTap();
                    },
                    child: JobRoleButtonWidget(
                      icon: Icons.groups_outlined,
                      text: 'I want an employee',
                      elevation: roleController.elevation2,
                      visibility: roleController.checkVisibility2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(right: width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      String userUID = FirebaseAuth.instance.currentUser!.uid;

                      var docRef = FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userUID);
                      if (roleController.selected == 1) {
                        docRef.update({'role': 'seeker'});
                        Get.off(SeekerProfileSettingScreen());
                      } else if (roleController.selected == 2) {
                        docRef.update({'role': 'recruiter'});
                        Get.off(RecruiterProfileSettingScreen());
                      } else {
                        Get.snackbar(
                          'Select',
                          'Select your role to continue',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    color: Colors.white70,
                    elevation: 2,
                    child: const Text(
                      'Start',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobRoleButtonWidget extends StatelessWidget {
  JobRoleButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.elevation,
    required this.visibility,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final double elevation;
  final bool visibility;

  final rolecontrol = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.41,
      height: height * 0.12,
      child: Material(
        elevation: elevation,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Visibility(
                visible: visibility,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
