import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';

class AddAboutPage extends StatelessWidget {
  AddAboutPage({super.key, this.userAbout});

  final aboutController = TextEditingController();
  final aboutFormkey = GlobalKey<FormState>();
  String? userAbout;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (userAbout != null && userAbout != "") {
        aboutController.text = userAbout!;
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Add About', style: subHeadlineStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.12),
        child: Column(
          children: [
            Form(
              key: aboutFormkey,
              child: Padding(
                padding: EdgeInsets.only(top: width * 0.08),
                child: TextFormField(
                  controller: aboutController,
                  maxLines: 7,
                  maxLength: 400,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Type something..';
                    }
                    return null;
                  },
                  decoration: textfieldInputDecoration('About', true),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        addbuttonClicked();
                      },
                      child: const Text('Add'),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.03),
                ElevatedButton(
                  onPressed: () {
                    deletebuttonClicked();
                  },
                  child: const Icon(
                    CupertinoIcons.delete,
                    color: Colors.red,
                    size: 19,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void addbuttonClicked() async {
    if (aboutFormkey.currentState!.validate()) {
      String currentUserID = FirebaseAuth.instance.currentUser!.uid;
      var userRef =
          FirebaseFirestore.instance.collection('Users').doc(currentUserID);
      await userRef.update({'About': aboutController.text.trim()});

      Get.back();
    }
  }

  void deletebuttonClicked() async {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    var userRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUserID);
    await userRef.update({'About': ""});
    Get.back();
  }
}
