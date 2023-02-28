import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/Find_jobs/view/widgets/find_jobs_listview.dart';
import 'package:lottie/lottie.dart';

class FindJobs extends StatelessWidget {
  FindJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width * 0.035),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              height: height * 0.032,
            ),
            Row(
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
                        size: 21,
                      ),
                    ),
                    clearButtonMode: OverlayVisibilityMode.editing,
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.cyan.withOpacity(0.2)),
                    ),
                    placeholder: 'Search',
                    placeholderStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                Container(
                  width: width * 0.088,
                  height: width * 0.088,
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.035,
            ),
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
                  return Column(
                    children: [
                      LottieBuilder.asset(
                        'assets/lottie/103199-hiring-pt-2.json',
                      ),
                    ],
                  );
                } else if (recruitersList.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: recruitersList.length,
                      itemBuilder: (context, index) {
                        String recruiterUID = recruitersList[index].id;
                        var vacanciesCollectionRef = FirebaseFirestore.instance
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
    );
  }
}
