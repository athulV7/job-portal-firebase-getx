import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/profile/model/addmore_details_model.dart';

class UserMoreDetailsWidget extends StatelessWidget {
  const UserMoreDetailsWidget({super.key, required this.recipientUID});

  final String recipientUID;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('Users')
          .doc(recipientUID)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        var aboutUser = snapshot.data!.data()!['About'];
        var moreDetails = snapshot.data!.data()!['moreDetails'];
        var moreDetailsModel = convertToModel(moreDetails);
        return moreDetails != null
            ? Material(
                color: Colors.white,
                elevation: 1,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    width * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('About', style: subHeadingNormal),
                      SizedBox(height: height * 0.01),
                      Text(aboutUser),
                      SizedBox(height: height * 0.02),
                      Row(
                        children: [
                          const Text(
                            'More details',
                            style: subHeadingNormal,
                          ),
                          SizedBox(width: width * 0.02),
                          Icon(
                            Icons.add_comment,
                            size: 19,
                            color: Colors.grey.shade800,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
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
              )
            : const Center(
                child: Text('No more details provide by this user'),
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
