import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/find_jobs_listview.dart';
import 'package:job_portal/screens/chat_front_screen/view/chat_front_screen.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.04, left: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.72,
                  child: CupertinoTextField(
                    padding: EdgeInsets.all(height * 0.01),
                    prefix: Padding(
                      padding: EdgeInsets.only(left: width * 0.02),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.shade600,
                        size: 19,
                      ),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    placeholder: 'Search',
                    placeholderStyle:
                        TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(const ChatFrontScreen());
                  },
                  icon: Icon(
                    Icons.sms,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 9,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Popular Jobs', style: subHeadlineStyle),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('recruiter')
                          .snapshots(),
                      // .doc(recruiterUID)
                      // .collection('vacancies')
                      // .orderBy('createdTime', descending: true)

                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        var recruitersList = snapshot.data!.docs;
                        if (recruitersList.isEmpty) {
                          log(recruitersList.length.toString());
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                LottieBuilder.asset(
                                  'assets/lottie/103199-hiring-pt-2.json',
                                ),
                              ],
                            ),
                          );
                        } else if (recruitersList.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: recruitersList.length,
                              itemBuilder: (context, index) {
                                String recruiterUID = recruitersList[index].id;
                                var vacanciesCollectionRef = FirebaseFirestore
                                    .instance
                                    .collection('recruiter')
                                    .doc(recruiterUID)
                                    .collection('vacancies');
                                return FindJobsList(
                                  vacancieCollectionRef: vacanciesCollectionRef,
                                );
                              });
                        } else {
                          return const SizedBox();
                        }
                        // vacancies listview
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextbuttonWidget extends StatelessWidget {
  const TextbuttonWidget({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          icon,
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
