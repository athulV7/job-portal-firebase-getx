import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/Recruter_screens/All_jobs/view/widgets/job_applied_details.dart';
import 'package:job_portal/screens/Recruter_screens/home/controller/home_screen_controller.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:badges/badges.dart' as badges;

class SearchResultWidget extends StatelessWidget {
  SearchResultWidget({super.key});

  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    String currentUserid = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        children: [
          const Text(
            'Search results',
            style: subHeadingNormal,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('recruiter')
                  .doc(currentUserid)
                  .collection('vacancies')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var searchResults = snapshot.data!.docs
                    .where(
                      (element) => element
                          .data()['title']
                          .toString()
                          .toLowerCase()
                          .contains(
                            homeScreenController.searchController.text
                                .toLowerCase(),
                          ),
                    )
                    .toList();
                if (searchResults.isEmpty) {
                  return const Center(child: Text('No Results'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      AddJobModel addJobModel =
                          AddJobModel.fromJson(searchResults[index].data());

                      return GestureDetector(
                        onTap: () {
                          Get.to(JobAppliedDetails(
                              currentJobId: addJobModel.jobId,
                              addJobModel: addJobModel));
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
                            padding: EdgeInsets.all(width * 0.033),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: width * 0.16,
                                      width: width * 0.16,
                                      child: const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/Screenshot 2023-03-06 113206.png'),
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
                                                    color:
                                                        Colors.green.shade200,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: addJobModel.location,
                                                  style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(width * 0.025),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            backgroundImage: AssetImage(
                                                'assets/images/3135715.png'),
                                            radius: 11,
                                          ),
                                          Transform.translate(
                                            offset: const Offset(5, 5),
                                            child: badges.Badge(
                                              badgeContent: Text(
                                                searchResults[index].data()[
                                                            'applied'] ==
                                                        null
                                                    ? '0'
                                                    : searchResults[index]
                                                        .data()['applied']
                                                        .length
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              badgeStyle: badges.BadgeStyle(
                                                badgeColor:
                                                    Colors.green.shade300,
                                                padding: EdgeInsets.all(
                                                    width * 0.008),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
                  );
                }
              }),
        ],
      ),
    );
  }
}
