import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class RecruiterProfileEditScreen extends StatelessWidget {
  RecruiterProfileEditScreen({super.key, required this.recruiterProfileModel});

  final RecruiterProfileModel recruiterProfileModel;
  final profileKey = GlobalKey<FormState>();
  final companyNameController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyAddressController = TextEditingController();
  final establishedDateController = TextEditingController();
  final countryController = TextEditingController();
  final userDpUrl = ''.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      companyNameController.text = recruiterProfileModel.companyName;
      companyEmailController.text = recruiterProfileModel.companyEmail;
      companyAddressController.text = recruiterProfileModel.companyAddress;
      establishedDateController.text = recruiterProfileModel.establishedDate;
      countryController.text = recruiterProfileModel.country;
      if (recruiterProfileModel.profilePic != null) {
        userDpUrl.value = recruiterProfileModel.profilePic!;
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.07),
            child: Form(
              key: profileKey,
              child: Column(
                children: [
                  SizedBox(
                    height: width * 0.3,
                    width: width * 0.3,
                    child: Stack(
                      children: [
                        Obx(() {
                          log('changing');

                          if (userDpUrl.value == '') {
                            return const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                  'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png'),
                              backgroundColor: Colors.green,
                            );
                          }
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(userDpUrl.value),
                            backgroundColor: Colors.green,
                          );
                        }),
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
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? image = await imagePicker.pickImage(
                                      source: ImageSource.gallery);

                                  if (image != null) {
                                    File profilePic = File(image.path);
                                    userDpUrl.value =
                                        await userUploadDp(profilePic);
                                  }
                                },
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
                    height: height * 0.03,
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
                  TextFormField(
                    controller: companyAddressController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration:
                        textfieldInputDecoration('Company Address', true),
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
                      decoration: textfieldInputDecoration('Country', false),
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
                        profileButtonClicked();
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

  //:::::________::::::::::::::::::::
  Future<String> userUploadDp(File profilePic) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('Users/dp/$currentUserId.jpg');

    await storageRef.putFile(profilePic);
    String userDpUrl = await storageRef.getDownloadURL();
    return userDpUrl;
  }

  void profileButtonClicked() async {
    if (profileKey.currentState!.validate()) {
      RecruiterProfileModel recruiterProfileModel = RecruiterProfileModel(
        profilePic: userDpUrl.value,
        companyName: companyNameController.text.trim(),
        companyEmail: companyEmailController.text.trim(),
        companyAddress: companyAddressController.text.trim(),
        establishedDate: establishedDateController.text.trim(),
        country: countryController.text.trim(),
      );

      String userUID = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userUID)
          .update({'profile': recruiterProfileModel.toJson()});

      //------------------------------

      Get.back();
    }
  }
}
