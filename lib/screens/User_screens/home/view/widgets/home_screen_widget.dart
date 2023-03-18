import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/find_jobs_listview.dart';
import 'package:lottie/lottie.dart';

class UserHomeScreenWidget extends StatelessWidget {
  const UserHomeScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  return const Center(child: CircularProgressIndicator());
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
                  return FindJobsList(
                    recruiterList: recruitersList,
                  );
                } else {
                  return const SizedBox();
                }
                // vacancies listview
              },
            ),
          ],
        ),
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
