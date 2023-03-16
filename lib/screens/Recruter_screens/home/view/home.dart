import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/home/controller/home_screen_controller.dart';
import 'package:job_portal/screens/Recruter_screens/home/view/widgets/home_screen_widget.dart';
import 'package:job_portal/screens/Recruter_screens/home/view/widgets/search_result_widget.dart';
import 'package:job_portal/screens/chat_front_screen/view/chat_front_screen.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';

class RecruterHomeScreen extends StatelessWidget {
  RecruterHomeScreen({super.key});

  final signInController = Get.put(SignInController());
  final homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    String recruiterUID = FirebaseAuth.instance.currentUser!.uid;
    homeScreenController.listenSearchController();
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
                      controller: homeScreenController.searchController,
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
                    onPressed: () {
                      Get.to(const ChatFrontScreen());
                    },
                    icon: Icon(
                      Icons.sms,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 9,
            ),
            GetBuilder<HomeScreenController>(builder: (context) {
              return homeScreenController.searchController.value.text.isEmpty
                  ? HomeScreenWidget(recruiterUID: recruiterUID)
                  : SearchResultWidget();
            })
          ],
        ),
      ),
    );
  }
}
