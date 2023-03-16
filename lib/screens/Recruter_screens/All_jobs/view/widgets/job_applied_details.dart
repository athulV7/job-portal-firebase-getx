import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/Recruter_screens/applied_users_profile_screen/applied_users_profile_screen.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class JobAppliedDetails extends StatelessWidget {
  const JobAppliedDetails(
      {super.key, required this.currentJobId, required this.addJobModel});

  final String currentJobId;
  final AddJobModel addJobModel;

  @override
  Widget build(BuildContext context) {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                // shape: RoundedRectangleBorder(
                //   side: const BorderSide(
                //     color: Colors.grey,
                //   ),
                //   borderRadius: BorderRadius.circular(12),
                // ),
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
                          // const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.delete_simple,
                              size: 20,
                              color: Colors.teal,
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
                            text: 'Expected Salary: ₹${addJobModel.salary}',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text('Experience', style: subHeadingNormal),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(addJobModel.experience),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Text('Qualification', style: subHeadingNormal),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(addJobModel.qualification),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      const Text('Full Job Description',
                          style: subHeadingNormal),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(addJobModel.description),
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'People Applied',
                  style: subHeadlineStyle,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('recruiter')
                    .doc(userUID)
                    .collection('vacancies')
                    .doc(currentJobId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data!.data()!['applied'] == null) {
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
                  List<dynamic> seekersUIDList = snapshot.data!.get('applied');
                  return AppliedPeoplesWidget(seekersUIDList: seekersUIDList);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppliedPeoplesWidget extends StatelessWidget {
  const AppliedPeoplesWidget({
    Key? key,
    required this.seekersUIDList,
  }) : super(key: key);

  final List seekersUIDList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: seekersUIDList.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(seekersUIDList[index]['uid'])
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return appliedPeopleTileShimmers();
            }
            String name = snapshot.data!.get('profile')['name'];
            String occupation = snapshot.data!.get('profile')['occupation'];
            return Padding(
              padding: EdgeInsets.only(bottom: width * 0.03),
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
                  child: Row(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            occupation,
                          )
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          var json = snapshot.data!.data()!['profile'];
                          var seekerID = snapshot.data!.id;
                          ProfileSettingModel profileSettingModel =
                              ProfileSettingModel.fromJson(json);
                          Get.to(AppliedUsersProfileScreen(
                            profileSettingModel: profileSettingModel,
                            recipentUID: seekerID,
                          ));
                        },
                        child: Material(
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Shimmer appliedPeopleTileShimmers() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Material(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
              ),
              SizedBox(
                width: width * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '',
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  const Text(
                    '',
                  )
                ],
              ),
              const Spacer(),
              Material(
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
