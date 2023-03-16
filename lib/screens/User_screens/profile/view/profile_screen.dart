import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Main_screen/main_screen.dart';
import 'package:job_portal/screens/User_screens/profile/view/profile_edit_screen.dart';
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () async {
            await signInController.googleSignOut();
            Get.offAll(const MainScreen());
          },
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.grey.shade800,
          ),
        )
      ]),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUserID)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          var userProfileRef = snapshot.data!.data()!['profile'];
          ProfileSettingModel profileSettingModel =
              ProfileSettingModel.fromJson(userProfileRef);
          return Padding(
            padding: EdgeInsets.only(
              right: width * 0.03,
              left: width * 0.03,
              //bottom: width * 0.03,
              top: width * 0.08,
            ),
            child: Column(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(currentUserID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      }
                      profileSettingModel = ProfileSettingModel.fromJson(
                          snapshot.data!.data()!['profile']);
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: height * 0.2,
                            margin: EdgeInsets.only(top: width * 0.19),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.cyan.withOpacity(0.1),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: width * 0.18),
                                  child: Text(
                                    profileSettingModel.name,
                                    style: subHeadingNormal,
                                  ),
                                ),
                                SizedBox(
                                  height: width * 0.02,
                                ),
                                Text(profileSettingModel.occupation),
                              ],
                            ),
                          ),
                          Center(
                            child: profileSettingModel.profilePic != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                      profileSettingModel.profilePic!,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: AssetImage(
                                      'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                          ),
                        ],
                      );
                    }),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: height * 0.3,
                    margin: EdgeInsets.only(top: width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      color: Colors.cyan.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: height * 0.08,
                          margin: EdgeInsets.all(width * 0.02),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: height * 0.08,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('CV  '),
                                        Icon(
                                          Icons.file_copy_outlined,
                                          size: 16,
                                          color: Colors.grey.shade700,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () async {
                                      Get.to(ProfileEditScreen(
                                        profileSettingModel:
                                            profileSettingModel,
                                      ));
                                    },
                                    height: height * 0.08,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text('Edit  '),
                                        Icon(
                                          Icons.edit_note,
                                          size: 20,
                                          color: Colors.grey.shade700,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: height * 0.08,
                            margin: EdgeInsets.only(
                              left: width * 0.02,
                              right: width * 0.02,
                              //bottom: width * 0.02,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.025),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    height: height * 0.08,
                                    elevation: 1,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.grey.shade50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'About  ',
                                          style: subHeadingNormal,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: Colors.grey.shade700,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  MaterialButton(
                                    height: height * 0.08,
                                    elevation: 1,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.grey.shade50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Add more details  ',
                                          style: subHeadingNormal,
                                        ),
                                        Icon(
                                          Icons.add_comment,
                                          size: 16,
                                          color: Colors.grey.shade700,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.025,
                                  ),
                                  const Text(
                                    'Recent Jobs You Applied',
                                    style: subHeadingNormal,
                                  ),
                                  // FutureBuilder(
                                  //   future: FirebaseFirestore.instance
                                  //       .collection('AppliedJobs')
                                  //       .doc(currentUserID)
                                  //       .get(),
                                  //   builder: (context, snapshot) {
                                  //     if (!snapshot.hasData) {
                                  //       return const SizedBox();
                                  //     }
                                  //     if (!snapshot.data!.exists) {
                                  //       const Text('No Applied Jobs');
                                  //     }
                                  //     var appliedJobsList =
                                  //         snapshot.data!.data()!['appliedJobs'];
                                  //     return ListView.builder(
                                  //       itemCount: appliedJobsList.length,
                                  //       itemBuilder: (context, index) {

                                  //       },
                                  //     );
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
