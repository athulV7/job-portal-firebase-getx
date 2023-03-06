import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/profile_setting_screen/model/profile_setting_model.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({super.key});

  final profileFormkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.12),
            child: Form(
              key: profileFormkey,
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
                            'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png',
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
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Name', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Age', false),
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
                      controller: occupationController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Occupation', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.14,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                      ),
                      onPressed: () {
                        profileButtonClicked();
                      },
                      child: const Text('Done'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void profileButtonClicked() async {
    if (profileFormkey.currentState!.validate()) {
      ProfileSettingModel profileSettingModel = ProfileSettingModel(
        name: nameController.text.trim(),
        age: int.parse(ageController.text),
        address: addressController.text.trim(),
        occupation: occupationController.text.trim(),
      );

      String userUID = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userUID)
          .update({'profile': profileSettingModel.toJson()});
    }
  }
}
