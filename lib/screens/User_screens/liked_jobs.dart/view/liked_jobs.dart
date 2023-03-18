import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/job_details_bottomsheet.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';
import 'package:lottie/lottie.dart';

class LikedJobs extends StatelessWidget {
  const LikedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Jobs',
          style: GoogleFonts.robotoSlab(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('SavedJobs')
              .doc(currentUserid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.data!.exists) {
              return Column(
                children: [
                  LottieBuilder.asset('assets/lottie/129959-empty.json'),
                  const Text("No saved Jobs"),
                ],
              );
            }
            var appliedJobsList = snapshot.data!.data()!['savedJobs'];
            if (appliedJobsList.isEmpty) {
              return Column(
                children: [
                  LottieBuilder.asset('assets/lottie/129959-empty.json'),
                  const Text("No saved Jobs"),
                ],
              );
            }

            return Padding(
              padding: EdgeInsets.all(width * 0.035),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: appliedJobsList.length,
                padding: EdgeInsets.only(top: height * 0.0),
                itemBuilder: (context, index) {
                  String jobID = appliedJobsList[index].keys.first;
                  AddJobModel addJobModel =
                      AddJobModel.fromJson(appliedJobsList[index][jobID]);

                  // var vacancieCollectionRef = FirebaseFirestore.instance
                  //     .collection('recruiter')
                  //     .doc(addJobModel.recruiterID)
                  //     .collection('vacancies');
                  return GestureDetector(
                    onTap: () {
                      //________________________________
                      jobDetailBottomsheet(addJobModel, jobID);
                    },
                    child: Material(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: width * 0.16,
                                  width: width * 0.16,
                                  //padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(addJobModel.recruiterID)
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const SizedBox();
                                        }
                                        RecruiterProfileModel
                                            recruiterProfileModel =
                                            RecruiterProfileModel.fromJson(
                                          snapshot.data!.data()!['profile'],
                                        );
                                        return recruiterProfileModel
                                                    .profilePic ==
                                                null
                                            ? const Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                  'assets/images/Screenshot 2023-03-06 113206.png',
                                                ),
                                              )
                                            : Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  recruiterProfileModel
                                                      .profilePic!,
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.location_city,
                                                size: 18,
                                                color: Colors.blue.shade300,
                                              ),
                                            ),
                                            TextSpan(
                                              text: addJobModel.companyName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        addJobModel.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.location_on_outlined,
                                                size: 19,
                                                color: Colors.green.shade200,
                                              ),
                                            ),
                                            TextSpan(
                                              text: addJobModel.location,
                                              style: TextStyle(
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //remove from saved jobs
                                    String currentJobID = addJobModel.jobId;
                                    String currentUID =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    FirebaseFirestore.instance
                                        .collection('SavedJobs')
                                        .doc(currentUID)
                                        .update({
                                      'savedJobs': FieldValue.arrayRemove([
                                        {currentJobID: addJobModel.toJson()}
                                      ])
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 22,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomMaterialButton(
                                  text: addJobModel.jobType!,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                CustomMaterialButton(
                                  text:
                                      'Expected Salary: ₹${addJobModel.salary}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
              ),
            );
          }),
    );
  }

  jobDetailBottomsheet(AddJobModel addJobModel, String currentJobId) {
    return Get.bottomSheet(
      isScrollControlled: true,
      JobDetailsBottomSheetwidget(
        addJobModel: addJobModel,
        currentJobId: currentJobId,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 0,
        color: Colors.cyan.withOpacity(0.1),
        textStyle: TextStyle(color: Colors.cyan.shade800),
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Text(text),
        ),
      ),
    );
  }
}
//---------------------
// getJobModels(String userUID, String jobID){
// FirebaseFirestore.instance.collection('SavedJobs').doc(userUID).
// }