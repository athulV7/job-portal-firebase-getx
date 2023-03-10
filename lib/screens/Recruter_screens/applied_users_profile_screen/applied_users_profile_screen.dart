import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/chat_personal_screen/view/recruiter_chat_personal_screen.dart';
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';

class AppliedUsersProfileScreen extends StatelessWidget {
  AppliedUsersProfileScreen(
      {super.key,
      required this.profileSettingModel,
      required this.recipentUID});

  final signInController = Get.put(SignInController());

  final ProfileSettingModel profileSettingModel;
  final String recipentUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: width * 0.03,
          left: width * 0.03,
          //bottom: width * 0.03,
          top: width * 0.08,
        ),
        child: Column(
          children: [
            Stack(
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
                        height: width * 0.07,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Get.to(RecruiterChatPersonalScreen(
                                  profileSettingModel: profileSettingModel,
                                  recipentUID: recipentUID,
                                ));
                              },
                              height: width * 0.1,
                              minWidth: width * 0.6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.facebookMessenger,
                                    size: 20,
                                    color: Colors.grey.shade700,
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  const Text('Message'),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {},
                                height: width * 0.1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Edit '),
                                    Icon(
                                      Icons.edit_note,
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: height * 0.3,
                margin: EdgeInsets.only(top: width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
