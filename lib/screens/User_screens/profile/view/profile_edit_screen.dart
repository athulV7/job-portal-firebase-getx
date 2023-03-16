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
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key, required this.profileSettingModel});

  final ProfileSettingModel profileSettingModel;
  final profileEditFormkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final occupationController = TextEditingController();
  final userDpUrl = ''.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = profileSettingModel.name;
      ageController.text = profileSettingModel.age.toString();
      addressController.text = profileSettingModel.address;
      occupationController.text = profileSettingModel.occupation;
      if (profileSettingModel.profilePic != null) {
        userDpUrl.value = profileSettingModel.profilePic!;
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
              key: profileEditFormkey,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> userUploadDp(File profilePic) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var storageRef =
        FirebaseStorage.instance.ref().child('Users/dp/$currentUserId.jpg');

    await storageRef.putFile(profilePic);
    String userDpUrl = await storageRef.getDownloadURL();
    return userDpUrl;
  }

  void profileButtonClicked() async {
    if (profileEditFormkey.currentState!.validate()) {
      ProfileSettingModel profileSettingModel = ProfileSettingModel(
        profilePic: userDpUrl.value,
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

      //------------------------------

      Get.back();
    }
  }
}
