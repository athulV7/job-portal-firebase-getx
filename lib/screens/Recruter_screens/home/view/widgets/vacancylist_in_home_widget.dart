import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/Recruter_screens/All_jobs/view/widgets/job_applied_details.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:badges/badges.dart' as badges;
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class VacancyJobsInHomeWidget extends StatelessWidget {
  const VacancyJobsInHomeWidget({
    Key? key,
    required this.length,
    required this.vacancyList,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> vacancyList;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 6),
      itemBuilder: (context, index) {
        AddJobModel addJobModel =
            AddJobModel.fromJson(vacancyList[index].data());

        return GestureDetector(
          onTap: () {
            var currentJobId = vacancyList[index].id;
            Get.to(JobAppliedDetails(
              currentJobId: currentJobId,
              addJobModel: addJobModel,
            ));
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
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(addJobModel.recruiterID)
                                .get(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox();
                              }
                              log(snapshot.data!.data()!['profile']
                                      ['profilePic'] ??
                                  'null');
                              RecruiterProfileModel recruiterProfileModel =
                                  RecruiterProfileModel.fromJson(
                                      snapshot.data!.data()!['profile']);
                              return recruiterProfileModel.profilePic == null
                                  ? const Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/Screenshot 2023-03-06 113206.png',
                                      ),
                                    )
                                  : Image(
                                      image: NetworkImage(
                                        recruiterProfileModel.profilePic!,
                                      ),
                                      fit: BoxFit.cover,
                                    );
                            }),
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
                                      overflow: TextOverflow.ellipsis,
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
                              backgroundImage:
                                  AssetImage('assets/images/3135715.png'),
                              radius: 11,
                            ),
                            Transform.translate(
                              offset: const Offset(5, 5),
                              child: badges.Badge(
                                badgeContent: Text(
                                  vacancyList[index].data()['applied'] == null
                                      ? '0'
                                      : vacancyList[index]
                                          .data()['applied']
                                          .length
                                          .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                                badgeStyle: badges.BadgeStyle(
                                  badgeColor: Colors.green.shade300,
                                  padding: EdgeInsets.all(width * 0.008),
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

                      // Container(
                      //   color: Colors.transparent,
                      //   padding: const EdgeInsets.all(5),
                      //   height: 50,
                      //   width: MediaQuery.of(context).size.width / 1.18,
                      //   child: ListView(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.horizontal,
                      //     children: [
                      //       // CustomMaterialButton(
                      //       //   text: addJobModel.jobType!,
                      //       // ),
                      //       // SizedBox(
                      //       //   width: width * 0.02,
                      //       // ),
                      //       // const CustomMaterialButton(
                      //       //   text: "Freelance",
                      //       // ),
                      //     ],
                      //   ),
                      // ),
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
    );
  }
}
