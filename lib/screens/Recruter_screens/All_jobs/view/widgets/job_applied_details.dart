import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';

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
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: width * 0.15),
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
                    List<dynamic> seekersUIDList =
                        snapshot.data!.get('applied');
                    return AppliedPeoplesWidget(seekersUIDList: seekersUIDList);
                  },
                ),
              ],
            ),
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
              .doc(seekersUIDList[index])
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
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
                        onTap: () {},
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
}
