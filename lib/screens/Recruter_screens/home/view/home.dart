import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../Main_screen/main_screen.dart';

class RecruterHomeScreen extends StatelessWidget {
  RecruterHomeScreen({super.key});

  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.04, left: width * 0.04),
              child: Row(
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
                          size: 19,
                        ),
                      ),
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      placeholder: 'Search',
                      placeholderStyle:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await signInController.googleSignOut();
                      Get.offAll(const MainScreen());
                    },
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 9,
            ),
            Padding(
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
                        onPressed: () {},
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
                            vacancyList: vacancyList);
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 6),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
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
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    const CircleAvatar(
                                      radius: 24,
                                    ),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Name',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        const Text(
                                          'Flutter Developer',
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        size: 22,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                const Divider(),
                                Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.cyan,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(width * 0.02),
                                    child: const Text(
                                      'View Profile',
                                      style: TextStyle(
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 3,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VacancyJobsInHomeWidget extends StatelessWidget {
  const VacancyJobsInHomeWidget({
    Key? key,
    required this.vacancyList,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> vacancyList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: vacancyList.length > 2 ? 2 : vacancyList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 6),
      itemBuilder: (context, index) {
        AddJobModel addJobModel =
            AddJobModel.fromJson(vacancyList[index].data());
        return GestureDetector(
          onTap: () {},
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
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(
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
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline,
                          size: 22,
                          color: Colors.grey,
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
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(5),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.18,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            CustomMaterialButton(
                              text: addJobModel.jobType!,
                            ),
                            // SizedBox(
                            //   width: width * 0.02,
                            // ),
                            // const CustomMaterialButton(
                            //   text: "Freelance",
                            // ),
                          ],
                        ),
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
    );
  }
}
