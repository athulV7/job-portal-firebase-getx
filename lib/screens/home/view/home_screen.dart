import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/home/view/widgets/bottomsheet_tabbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width * 0.035),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade200.withOpacity(0.13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Welcome\n',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              height: height * 0.03,
                            ),
                          ),
                          TextSpan(
                            text: 'Name',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_rounded),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    'Find',
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'Your Dream Job',
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.72,
                        child: CupertinoTextField(
                          padding: EdgeInsets.all(height * 0.015),
                          prefix: Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          placeholder: 'Search',
                        ),
                      ),
                      Container(
                        width: width * 0.11,
                        height: width * 0.11,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Popular Jobs',
                        style: GoogleFonts.robotoSlab(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See all',
                          style: GoogleFonts.robotoSlab(
                            textStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 6),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            jobDetailsBottomsheet();
                          },
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              text: 'Company\n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: SizedBox(
                                                height: height * 0.03,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: 'Product Designer',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                          text: 'Location,Location',
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: width * 0.013),
                                    child: Row(
                                      children: [
                                        Material(
                                          elevation: 1,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.02),
                                            child: const Text('Full-Time'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.02,
                                        ),
                                        Material(
                                          elevation: 1,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(width * 0.02),
                                            child: const Text('Freelance'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 5,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  jobDetailsBottomsheet() {
    return Get.bottomSheet(
      SizedBox(
        child: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Column(
            children: [
              Text(
                'Product Designer',
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
              const Text(
                'Company',
                style: TextStyle(
                  //fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ChoiceChip(
                    avatar: Icon(
                      Icons.work_history_outlined,
                      size: 18,
                    ),
                    label: Text('Full-Time'),
                    selected: true,
                    backgroundColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    elevation: 0,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  const ChoiceChip(
                    avatar: Icon(
                      Icons.work_history_outlined,
                      size: 18,
                    ),
                    label: Text('Freelance'),
                    selected: true,
                    backgroundColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    elevation: 0,
                  )
                ],
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
                  child: const BottomSheetTabBar(),
                ),
              ),
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
}
