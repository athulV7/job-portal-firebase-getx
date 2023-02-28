import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/controller/add_job_controller.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/view/widgets/industry_drop_down.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/view/widgets/jobtype_drop_drown.dart';

class AddJobScreen extends StatelessWidget {
  AddJobScreen({super.key});

  final addJobController = Get.put(AddJobController());
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final salaryController = TextEditingController();

  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final companyNameController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Create Vacancies',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.04),
            child: Form(
              key: addJobController.formKeyJob,
              child: Column(
                children: [
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Job title', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    decoration: textfieldInputDecoration('Description', true),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GetBuilder<AddJobController>(
                    builder: (controller) => Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: width * 0.13,
                            child: TextFormField(
                              controller: salaryController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              decoration:
                                  textfieldInputDecoration('Salary', false),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.025,
                        ),
                        SizedBox(
                          height: width * 0.13,
                          width: width * 0.25,
                          child: TextFormField(
                            controller: addJobController.positionsController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            decoration:
                                textfieldInputDecoration('positions', false),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.08,
                          height: width * 0.08,
                          child: TextButton(
                            onPressed: () {
                              addJobController.positionsAddButtonClicked();
                            },
                            child: const Icon(
                              Icons.add,
                              size: 21,
                              color: Colors.black,
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
                      controller: qualificationController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration:
                          textfieldInputDecoration('Qualification', false),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: width * 0.13,
                          child: TextFormField(
                            controller: experienceController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            decoration:
                                textfieldInputDecoration('Experience', false),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.03,
                      ),

                      //job type dropdown button
                      JobTypeDropDown(),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: TextFormField(
                      controller: companyNameController,
                      keyboardType: TextInputType.name,
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
                      controller: locationController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      decoration: textfieldInputDecoration('Location', false),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.05,
                  ),
                  //industry type dropdown button
                  IndustryDropDown(),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: ElevatedButton(
                      onPressed: postJobButtonClicked,
                      child: const Text(
                        "Post Job",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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

  void postJobButtonClicked() async {
    if (addJobController.formKeyJob.currentState!.validate()) {
      if (addJobController.selectedIndex != null &&
          addJobController.selectedOption != null) {
        AddJobModel addJobModel = AddJobModel(
          title: titleController.text,
          description: descriptionController.text,
          salary: salaryController.text,
          positions: int.parse(addJobController.positionsController.text),
          qualification: qualificationController.text,
          experience: experienceController.text,
          jobType: addJobController.selectedIndex,
          companyName: companyNameController.text,
          location: locationController.text,
          industry: addJobController.selectedOption,
          createdTime: DateTime.now().toString(),
        );
        //-----------
        String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
        var jobDocRef = FirebaseFirestore.instance
            .collection('recruiter')
            .doc(recruiterUID)
            .collection('vacancies')
            .doc();
        FirebaseFirestore.instance
            .collection('recruiter')
            .doc(recruiterUID)
            .set({'k': ''});
        await jobDocRef.set(addJobModel.toJson());
        log('Job Vacancy Added');
        addJobController.selectedIndex = null;
        addJobController.selectedOption = null;
        Get.back();
      } else {
        Get.snackbar(
          'Select',
          'please select Job type and Industry',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

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
}
