import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/view/add_new_jobs.dart';
import 'package:job_portal/screens/Recruter_screens/home/view/widgets/vacancylist_in_home_widget.dart';
import 'package:lottie/lottie.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Vacancies',
          style: GoogleFonts.robotoSlab(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        //centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(width * 0.025),
            child: MaterialButton(
              onPressed: () {
                Get.to(AddJobScreen());
              },
              color: Colors.green,
              child: const Text(
                'Post a new Job',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('recruiter')
                .doc(recruiterUID)
                .collection('vacancies')
                .orderBy('createdTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var vacancyList = snapshot.data!.docs;
              if (vacancyList.isEmpty) {
                return Column(
                  children: [
                    LottieBuilder.asset(
                      'assets/lottie/103199-hiring-pt-2.json',
                    ),
                    const Text("You don't have any posts yet!!"),
                    const Text('Create new Vacancies'),
                  ],
                );
              } else if (vacancyList.isNotEmpty) {
                return VacancyJobsInHomeWidget(
                  vacancyList: vacancyList,
                  length: vacancyList.length,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
