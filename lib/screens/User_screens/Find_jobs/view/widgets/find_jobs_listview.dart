import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';
import 'package:job_portal/screens/User_screens/Find_jobs/view/widgets/bottomsheet_tabbar.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';

class FindJobsList extends StatelessWidget {
  const FindJobsList({super.key, required this.vacancieCollectionRef});

  final CollectionReference<Map<String, dynamic>> vacancieCollectionRef;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: vacancieCollectionRef.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var vacancyList = snapshot.data!.docs;
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: width * 0.03),
            itemBuilder: (context, index) {
              AddJobModel addJobModel =
                  AddJobModel.fromJson(vacancyList[index].data());

              return GestureDetector(
                onTap: () {
                  jobDetailsBottomsheet(addJobModel);
                },
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
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: vacancyList.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
            ),
          );
        });
  }

  //job details when clicking list tile
  jobDetailsBottomsheet(AddJobModel addJobModel) {
    return Get.bottomSheet(
      isScrollControlled: true,
      SizedBox(
        height: height * 0.7,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                height: width * 0.15,
                width: width * 0.15,
                color: Colors.amber,
                child: Image(image: AssetImage('')),
              ),
              Text(
                addJobModel.title,
                style: GoogleFonts.robotoSlab(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                addJobModel.companyName,
                style: const TextStyle(
                  //fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                addJobModel.industry.toString(),
                style: TextStyle(
                  //fontSize: 22,
                  fontWeight: FontWeight.w500,
                  backgroundColor: Colors.cyan.withOpacity(0.05),
                ),
              ),

              ChoiceChip(
                avatar: const Icon(
                  Icons.work_history_outlined,
                  size: 18,
                ),
                label: Text(addJobModel.jobType.toString()),
                selected: true,
                backgroundColor: Colors.transparent,
                selectedColor: Colors.transparent,
                elevation: 0,
              ),
              SizedBox(
                height: height * 0.01,
              ),

              //-----------------
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BottomSheetTabBar(
                    addJobModel: addJobModel,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.8,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Apply Job',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              //------------------------
              //setJobImage(addJobModel)
              //---------------------------
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  //:::::::::::::------------------------
  // setJobImage(AddJobModel addJobModel) {
  //   if(addJobModel.industry == 'Busienss')
  // }
}
