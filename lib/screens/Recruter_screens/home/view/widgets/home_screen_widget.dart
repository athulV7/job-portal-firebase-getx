import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/All_jobs/view/all_jobs.dart';
import 'package:job_portal/screens/Recruter_screens/applied_users_profile_screen/applied_users_profile_screen.dart';
import 'package:job_portal/screens/Recruter_screens/home/view/widgets/vacancylist_in_home_widget.dart';
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    Key? key,
    required this.recruiterUID,
  }) : super(key: key);

  final String recruiterUID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Vacancies',
                style: subHeadlineStyle,
              ),
              TextButton(
                onPressed: () {
                  Get.to(const AllJobsScreen());
                },
                child: const Text('View all'),
              ),
            ],
          ),

          //:::::::---------------------:::::::::
          SizedBox(
            height: height * 0.01,
          ),
          StreamBuilder(
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
                  length: vacancyList.length > 2 ? 2 : vacancyList.length,
                  vacancyList: vacancyList,
                );
              } else {
                return const SizedBox();
              }
              // vacancies listview
            },
          ),

          //::::::::---------------------------:::::::::::::
          SizedBox(
            height: height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Recent people Applied', style: subHeadlineStyle),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('recruiter')
                  .doc(recruiterUID)
                  .collection('vacancies')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var vacanciesList = snapshot.data!.docs;
                List<dynamic> appliedUsersList = [];
                for (var vacancy in vacanciesList) {
                  if (vacancy.data()['applied'] != null) {
                    appliedUsersList.addAll(vacancy.data()['applied']);
                  }
                }
                appliedUsersList.sort(
                  (a, b) => b['appliedTime']!.compareTo(a['appliedTime']!),
                );
                if (appliedUsersList.isEmpty) {
                  return Column(
                    children: [
                      LottieBuilder.asset(
                        'assets/lottie/6819-resume.json',
                      ),
                      const Text('No People applied', style: thirdTextStyle),
                      SizedBox(
                        height: height * 0.03,
                      )
                    ],
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 6),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(appliedUsersList[index]['uid'])
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          ProfileSettingModel profileSettingModel =
                              ProfileSettingModel.fromJson(
                                  snapshot.data!.data()!['profile']);
                          return GestureDetector(
                            onTap: () {},
                            child: Material(
                              elevation: 2,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                // side: const BorderSide(
                                //   color: Colors.grey,
                                // ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      //crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        const CircleAvatar(
                                          radius: 24,
                                          backgroundImage: AssetImage(
                                              'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png'),
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              profileSettingModel.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Text(
                                              profileSettingModel.occupation,
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        MaterialButton(
                                          elevation: 0,
                                          onPressed: () {
                                            Get.to(
                                              AppliedUsersProfileScreen(
                                                profileSettingModel:
                                                    profileSettingModel,
                                                recipentUID:
                                                    appliedUsersList[index]
                                                        ['uid'],
                                              ),
                                            );
                                          },
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              color: Colors.cyan,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Text(
                                            'View Profile',
                                            style: TextStyle(
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    const Divider(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'See Resume',
                                        style: TextStyle(
                                          color: Colors.cyan,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  itemCount:
                      appliedUsersList.length > 4 ? 4 : appliedUsersList.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                  ),
                );
              })
        ],
      ),
    );
  }
}
