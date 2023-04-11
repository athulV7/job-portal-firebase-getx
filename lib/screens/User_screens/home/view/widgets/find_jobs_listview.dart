import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/home/controller/findjobs_controller.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/job_details_bottomsheet.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class FindJobsList extends StatelessWidget {
  FindJobsList({super.key, required this.recruiterList});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> recruiterList;
  final findJobsController = Get.put(FindJobsController());

  @override
  Widget build(BuildContext context) {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder(
        future: getJobList(recruiterList),
        builder: (context, snapshot) {
          //log(snapshot.data!.docs.first.id);
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var vacancyList = snapshot.data!;

          vacancyList.sort(
            (a, b) => b.createdTime.compareTo(a.createdTime),
          );

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: width * 0.03),
            itemBuilder: (context, index) {
              AddJobModel addJobModel = vacancyList[index];

              return GestureDetector(
                onTap: () {
                  // log(addJobModel.id);
                  String currentJobId = vacancyList[index].jobId;
                  jobDetailsBottomsheet(addJobModel, currentJobId);
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
                                color: Colors.white54,
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
                                              snapshot.data!
                                                  .data()!['profile']);
                                      return recruiterProfileModel.profilePic ==
                                              null
                                          ? const Image(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/Screenshot 2023-03-06 113206.png'),
                                            )
                                          : Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                recruiterProfileModel
                                                    .profilePic!,
                                              ),
                                            );
                                    }),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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

                            //wrapped with a stream builder for checking the job is saved or not.
                            //if the job is saved then return the liked icon widget
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SavedJobs')
                                  .doc(currentUserUID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const SizedBox();
                                }

                                bool isSaved = false;

                                if (snapshot.data!.data() == null) {
                                  return IconButton(
                                    onPressed: () {
                                      String currentJobId =
                                          vacancyList[index].jobId;
                                      favoriteButtonClicked(
                                          currentJobId, addJobModel);
                                    },
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      size: 22,
                                      color: Colors.grey,
                                    ),
                                  );
                                }
                                //checking the job is in saved jobs field
                                for (var element
                                    in snapshot.data!.data()!['savedJobs']) {
                                  if (element.keys.first == addJobModel.jobId) {
                                    isSaved = true;
                                  }
                                }
                                if (isSaved) {
                                  return IconButton(
                                    onPressed: () {
                                      //remove from saved jobs
                                      String currentJobId =
                                          vacancyList[index].jobId;
                                      String currentUID = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      FirebaseFirestore.instance
                                          .collection('SavedJobs')
                                          .doc(currentUID)
                                          .update({
                                        'savedJobs': FieldValue.arrayRemove([
                                          {currentJobId: addJobModel.toJson()}
                                        ])
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      size: 22,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                                return IconButton(
                                  onPressed: () {
                                    String currentJobId =
                                        vacancyList[index].jobId;
                                    favoriteButtonClicked(
                                        currentJobId, addJobModel);
                                  },
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                    size: 22,
                                    color: Colors.grey,
                                  ),
                                );
                              },
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
                              text: 'Expected Salary: ₹${addJobModel.salary}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: vacancyList.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
          );
        });
  }

  Future<void> favoriteButtonClicked(
      String currentJobID, AddJobModel addJobModel) async {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;

    var appliedJobsRef = await FirebaseFirestore.instance
        .collection('SavedJobs')
        .doc(currentUserID)
        .get();
    if (appliedJobsRef.exists) {
      FirebaseFirestore.instance
          .collection('SavedJobs')
          .doc(currentUserID)
          .update({
        'savedJobs': FieldValue.arrayUnion([
          {currentJobID: addJobModel.toJson()}
        ])
      });
    } else {
      FirebaseFirestore.instance
          .collection('SavedJobs')
          .doc(currentUserID)
          .set({
        'savedJobs': FieldValue.arrayUnion([
          {currentJobID: addJobModel.toJson()}
        ])
      });
    }
  }

  //job details when clicking list tile
  jobDetailsBottomsheet(AddJobModel addJobModel, String currentJobId) {
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

Future<List<AddJobModel>> getJobList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> recruitersList) async {
  List<AddJobModel> jobList = [];
  for (var recruiter in recruitersList) {
    var vacanciesList = await FirebaseFirestore.instance
        .collection('recruiter')
        .doc(recruiter.id)
        .collection('vacancies')
        .get();

    for (var vacancy in vacanciesList.docs) {
      AddJobModel addJobModel = AddJobModel.fromJson(vacancy.data());
      jobList.add(addJobModel);
    }
  }
  return jobList;
}
