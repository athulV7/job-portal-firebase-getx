import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/view/add_new_jobs.dart';

class AllJobsScreen extends StatelessWidget {
  const AllJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
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
    );
  }
}
