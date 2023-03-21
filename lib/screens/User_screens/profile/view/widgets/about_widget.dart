import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/profile/view/add_about_page.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({
    Key? key,
    required this.currentUserID,
  }) : super(key: key);

  final String currentUserID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUserID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        var userAbout = snapshot.data!.data()!['About'];
        return userAbout == null || userAbout == ""
            ? MaterialButton(
                height: height * 0.08,
                elevation: 1,
                onPressed: () {
                  Get.to(AddAboutPage());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: Colors.grey.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
              )
            : Material(
                color: Colors.grey.shade50,
                elevation: 1,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    width * 0.03,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'About',
                            style: subHeadingNormal,
                          ),
                          IconButton(
                            onPressed: () => Get.to(
                              () => AddAboutPage(
                                userAbout: userAbout,
                              ),
                            ),
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Text(userAbout),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
