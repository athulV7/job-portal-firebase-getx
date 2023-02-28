import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_portal/core/common.dart';

class LikedJobs extends StatelessWidget {
  const LikedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                    bottom: height * 0.02,
                  ),
                  child: Text(
                    'My Jobs',
                    style: GoogleFonts.robotoSlab(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: height * 0.0),
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 2,
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
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 22,
                                      color: Colors.grey.shade800,
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
                                padding: EdgeInsets.only(bottom: width * 0.013),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          const CustomMaterialButton(
                                            text: "Full-Time",
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          const CustomMaterialButton(
                                            text: "Freelance",
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.04,
                                    ),
                                    Material(
                                      color: Colors.green,
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(5),
                                      child: Padding(
                                        padding: EdgeInsets.all(width * 0.02),
                                        child: const Text(
                                          'Apply Job',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 5,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 0,
        color: Colors.cyan.withOpacity(0.1),
        textStyle: TextStyle(color: Colors.cyan.shade800),
        borderRadius: BorderRadius.circular(5),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Text(text),
        ),
      ),
    );
  }
}
