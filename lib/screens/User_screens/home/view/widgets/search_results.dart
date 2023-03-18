import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/home/controller/findjobs_controller.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/find_jobs_listview.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/job_details_bottomsheet.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:lottie/lottie.dart';

class SearchResults extends StatelessWidget {
  SearchResults({super.key});

  final findjobController = Get.put(FindJobsController());

  @override
  Widget build(BuildContext context) {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        children: [
          const Text(
            'Search results',
            style: subHeadingNormal,
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('recruiter').snapshots(),
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
                return FutureBuilder(
                  future: getJobList(recruitersList),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    var searchResults = snapshot.data!
                        .where((element) => element.title
                            .toLowerCase()
                            .contains(findjobController.searchController.text
                                .toLowerCase()))
                        .toList();

                    if (searchResults.isEmpty) {
                      return const Center(
                        child: Text('No results'),
                      );
                    } else {
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                jobDetailsBottomsheet(searchResults[index],
                                    searchResults[index].jobId);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: width * 0.16,
                                            width: width * 0.16,
                                            //padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              color: Colors.amber,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              child: const Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/Screenshot 2023-03-06 113206.png'),
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
                                                          color: Colors
                                                              .blue.shade300,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            searchResults[index]
                                                                .companyName,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .grey.shade400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  searchResults[index].title,
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
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 19,
                                                          color: Colors
                                                              .green.shade200,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            searchResults[index]
                                                                .location,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade400,
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
                                                .doc(currentUserID)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const SizedBox();
                                              }

                                              bool isSaved = false;

                                              if (snapshot.data!.data() ==
                                                  null) {
                                                return IconButton(
                                                  onPressed: () {
                                                    String currentJobId =
                                                        searchResults[index]
                                                            .jobId;
                                                    favoriteButtonClicked(
                                                      currentJobId,
                                                      searchResults[index],
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite_outline,
                                                    size: 22,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              }
                                              //checking the job is in saved jobs field
                                              for (var element in snapshot.data!
                                                  .data()!['savedJobs']) {
                                                if (element.keys.first ==
                                                    searchResults[index]
                                                        .jobId) {
                                                  isSaved = true;
                                                }
                                              }
                                              if (isSaved) {
                                                return IconButton(
                                                  onPressed: () {
                                                    //remove from saved jobs
                                                    String currentJobId =
                                                        searchResults[index]
                                                            .jobId;
                                                    String currentUID =
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid;

                                                    FirebaseFirestore.instance
                                                        .collection('SavedJobs')
                                                        .doc(currentUID)
                                                        .update({
                                                      'savedJobs': FieldValue
                                                          .arrayRemove([
                                                        {
                                                          currentJobId:
                                                              searchResults[
                                                                      index]
                                                                  .toJson()
                                                        }
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
                                                      searchResults[index]
                                                          .jobId;
                                                  favoriteButtonClicked(
                                                      currentJobId,
                                                      searchResults[index]);
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomMaterialButton(
                                            text: searchResults[index].jobType!,
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          CustomMaterialButton(
                                            text:
                                                'Expected Salary: ₹${searchResults[index].salary}',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
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

  //------------------------
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
