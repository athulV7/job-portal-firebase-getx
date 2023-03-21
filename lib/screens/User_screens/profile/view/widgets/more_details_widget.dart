import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/profile/model/addmore_details_model.dart';
import 'package:job_portal/screens/User_screens/profile/view/add_more_details_page.dart';

class MoreDetailsWidget extends StatelessWidget {
  const MoreDetailsWidget({
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

        var moreInfo = snapshot.data!.data()!['moreDetails'];
        var moreDetailsModel = convertToModel(moreInfo);

        return moreInfo == null || moreInfo == ""
            ? MaterialButton(
                height: height * 0.08,
                elevation: 1,
                onPressed: () => Get.to(
                  () => AddMoreDetailsPage(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: Colors.grey.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'More details',
                            style: subHeadingNormal,
                          ),
                          TextButton.icon(
                            onPressed: () => Get.to(
                              () => AddMoreDetailsPage(
                                moreDetailsModel: moreDetailsModel,
                              ),
                            ),
                            label: const Text('Edit'),
                            icon: const Icon(
                              Icons.add_comment,
                              size: 19,
                            ),
                          ),
                        ],
                      ),
                      const Text("Skills", style: subHeadingNormal),
                      SizedBox(height: height * 0.01),
                      Text(moreDetailsModel.skills),
                      SizedBox(height: height * 0.02),
                      const Text("Education", style: subHeadingNormal),
                      SizedBox(height: height * 0.01),
                      Text(moreDetailsModel.education),
                      SizedBox(height: height * 0.02),
                      const Text("Experience", style: subHeadingNormal),
                      SizedBox(height: height * 0.01),
                      Text(moreDetailsModel.experience),
                      SizedBox(height: height * 0.02),
                      const Text("Contact No.", style: subHeadingNormal),
                      SizedBox(height: height * 0.01),
                      Text(moreDetailsModel.contactNo.toString()),
                    ],
                  ),
                ),
              );
      },
    );
  }

  dynamic convertToModel(moreInfo) {
    if (moreInfo != null) {
      MoreDetailsModel moreDetailsModel = MoreDetailsModel.fromJson(moreInfo);
      return moreDetailsModel;
    }
  }
}
