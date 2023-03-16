import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/home/controller/findjobs_controller.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/home_screen_widget.dart';
import 'package:job_portal/screens/User_screens/home/view/widgets/search_results.dart';
import 'package:job_portal/screens/chat_front_screen/view/chat_front_screen.dart';
import 'package:job_portal/screens/sign_in/controller/sign_in_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final signInController = Get.put(SignInController());
  final findjobsController = Get.put(FindJobsController());

  @override
  Widget build(BuildContext context) {
    findjobsController.listenSearchController();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.04, left: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.72,
                  child: CupertinoTextField(
                    controller: findjobsController.searchController,
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
          GetBuilder<FindJobsController>(
            builder: (context) {
              return findjobsController.searchController.text.isEmpty
                  ? UserHomeScreenWidget()
                  : SearchResults();
            },
          )
        ],
      ),
    );
  }
}
