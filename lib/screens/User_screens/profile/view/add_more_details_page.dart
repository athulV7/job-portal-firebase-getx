import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/profile/model/addmore_details_model.dart';

class AddMoreDetailsPage extends StatelessWidget {
  AddMoreDetailsPage({super.key, this.moreDetailsModel});

  final moreFormkey = GlobalKey<FormState>();
  final skillsController = TextEditingController();
  final educationController = TextEditingController();
  final experienceController = TextEditingController();
  final contactController = TextEditingController();
  MoreDetailsModel? moreDetailsModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (moreDetailsModel != null) {
        skillsController.text = moreDetailsModel!.skills;
        educationController.text = moreDetailsModel!.education;
        experienceController.text = moreDetailsModel!.experience;
        contactController.text = moreDetailsModel!.contactNo.toString();
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Add more Details',
          style: subHeadlineStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              Form(
                key: moreFormkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: skillsController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Add your skills';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Skills', true),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      controller: educationController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Add educational Qualification';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Education', false),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      controller: experienceController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Add Your experience';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Experience', false),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SizedBox(
                      height: width * 0.13,
                      child: TextFormField(
                        controller: contactController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add a contact number';
                          } else if (value.length < 10 || value.length > 10) {
                            return 'Enter a valid contact number';
                          }
                          return null;
                        },
                        decoration:
                            textfieldInputDecoration('Contact No.', false),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        addButtonClicked();
                      },
                      child: const Text('Add'),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      deleteButtonClicked();
                    },
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.red,
                      size: 19,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addButtonClicked() async {
    if (moreFormkey.currentState!.validate()) {
      MoreDetailsModel moreDetailsModel = MoreDetailsModel(
        skills: skillsController.text,
        education: educationController.text,
        experience: experienceController.text,
        contactNo: int.parse(contactController.text),
      );
      String currentUid = FirebaseAuth.instance.currentUser!.uid;
      var userRef =
          FirebaseFirestore.instance.collection('Users').doc(currentUid);
      await userRef.update({'moreDetails': moreDetailsModel.toJson()});

      Get.back();
    }
  }

  void deleteButtonClicked() async {
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    var userRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUid);
    await userRef.update({'moreDetails': FieldValue.delete()});

    Get.back();
  }
}
