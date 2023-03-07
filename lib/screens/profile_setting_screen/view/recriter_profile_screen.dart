import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/widgets/recruter_bottom_nav.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class RecruiterProfileSettingScreen extends StatelessWidget {
  RecruiterProfileSettingScreen({super.key});

  final recProfileFormkey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final establishedDateController = TextEditingController();
  final addressController = TextEditingController();
  final countryController = TextEditingController();
  final companyEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.12),
            child: Form(
              key: recProfileFormkey,
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  SizedBox(
                    height: width * 0.3,
                    width: width * 0.3,
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                            'assets/images/Screenshot 2023-03-06 113206.png',
                          ),
                          backgroundColor: Colors.green,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: width * 0.015,
                              right: width * 0.015,
                            ),
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                  size: 19,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: companyNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration:
                          textfieldInputDecoration('Company Name', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: companyEmailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration:
                          textfieldInputDecoration('Company Email', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: establishedDateController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration:
                          textfieldInputDecoration('Established Date', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: textfieldInputDecoration('Address', true),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: countryController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration:
                          textfieldInputDecoration('Country of origin', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                      ),
                      onPressed: () {
                        recProfileButtonClicked();
                      },
                      child: const Text('Done'),
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

  void recProfileButtonClicked() async {
    if (recProfileFormkey.currentState!.validate()) {
      RecruiterProfileModel recruiterProfileModel = RecruiterProfileModel(
        companyName: companyNameController.text.trim(),
        companyEmail: companyEmailController.text.trim(),
        establishedDate: establishedDateController.text.trim(),
        companyAddress: addressController.text.trim(),
        country: countryController.text.trim(),
      );

      String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(recruiterUID)
          .update({'profile': recruiterProfileModel.toJson()});

      //--------------------
      Get.off(RecruterBottomNavbar());
    }
  }
}
