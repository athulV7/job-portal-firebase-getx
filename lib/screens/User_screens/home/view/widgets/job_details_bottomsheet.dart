import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/home/controller/findjobs_controller.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/bottomsheet_tabbar.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class JobDetailsBottomSheetwidget extends StatelessWidget {
  JobDetailsBottomSheetwidget({
    super.key,
    required this.addJobModel,
    required this.currentJobId,
  });

  final AddJobModel addJobModel;
  final String currentJobId;
  final findJobsController = Get.put(FindJobsController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.7,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(addJobModel.recruiterID)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  RecruiterProfileModel recruiterProfileModel =
                      RecruiterProfileModel.fromJson(
                    snapshot.data!.data()!['profile'],
                  );
                  return Container(
                    height: width * 0.15,
                    width: width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.amber,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: recruiterProfileModel.profilePic == null
                          ? const Image(
                              image: AssetImage(
                                'assets/images/Screenshot 2023-03-06 113206.png',
                              ),
                            )
                          : Image(
                              image: NetworkImage(
                                  recruiterProfileModel.profilePic!),
                            ),
                    ),
                  );
                }),
            Text(
              addJobModel.title,
              style: GoogleFonts.robotoSlab(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              addJobModel.companyName,
              style: const TextStyle(
                //fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              addJobModel.industry.toString(),
              style: TextStyle(
                //fontSize: 22,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.cyan.withOpacity(0.05),
              ),
            ),

            ChoiceChip(
              avatar: const Icon(
                Icons.work_history_outlined,
                size: 18,
              ),
              label: Text(addJobModel.jobType.toString()),
              selected: true,
              backgroundColor: Colors.transparent,
              selectedColor: Colors.transparent,
              elevation: 0,
            ),
            SizedBox(
              height: height * 0.01,
            ),

            //-----------------
            Expanded(
              child: Container(
                padding: EdgeInsets.all(width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BottomSheetTabBar(
                  addJobModel: addJobModel,
                ),
              ),
            ),
            FutureBuilder(
              future: findJobsController.checkUserJobApplied(
                  FirebaseAuth.instance.currentUser!.uid, currentJobId),
              builder: (context, snapshot) {
                return !(snapshot.connectionState == ConnectionState.done)
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: width * 0.8,
                        child: ElevatedButton(
                          onPressed: () async {
                            String userID =
                                FirebaseAuth.instance.currentUser!.uid;
                            String recruiterID = addJobModel.recruiterID;
                            FirebaseFirestore.instance
                                .collection('recruiter')
                                .doc(recruiterID)
                                .collection('vacancies')
                                .doc(currentJobId)
                                .update(
                              {
                                'applied': FieldValue.arrayUnion([
                                  {'uid': userID, 'appliedTime': DateTime.now()}
                                ])
                              },
                            );
                            findJobsController.applyButtonClicked(
                                userID, currentJobId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: GetBuilder<FindJobsController>(
                            builder: (controller) => Text(
                              findJobsController.applyButton == 'notApplied'
                                  ? 'Apply Job'
                                  : 'Applied',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
