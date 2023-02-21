import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/User_screens/sign_in/controller/sign_in_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.04, left: width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.72,
                  child: CupertinoTextField(
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
                    signInController.googleSignOut();
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
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: width * 0.03,
                  left: width * 0.03,
                  right: width * 0.03,
                ),
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              CupertinoIcons.person_alt_circle,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Text(
                        '"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness.',
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.green,
                        child: Image.network(
                          'https://media.istockphoto.com/id/1451309715/photo/young-asian-woman-software-developers-mentor-leader-manager-talking-to-executive-team.jpg?b=1&s=170667a&w=0&k=20&c=rukaDl4U706Yop35WNn8L3ySxz5tjSvTsuc0COZA0vQ=',
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextbuttonWidget(
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 18,
                              color: Colors.grey.shade800,
                            ),
                            label: 'Like',
                          ),
                          TextbuttonWidget(
                            icon: Icon(
                              CupertinoIcons.text_bubble,
                              size: 18,
                              color: Colors.grey.shade800,
                            ),
                            label: 'Comment',
                          ),
                          TextbuttonWidget(
                            icon: Icon(
                              Icons.send,
                              size: 18,
                              color: Colors.grey.shade800,
                            ),
                            label: 'share',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(
              thickness: 7,
            ),
          ),
        ],
      ),
    );
  }
}

class TextbuttonWidget extends StatelessWidget {
  const TextbuttonWidget({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          icon,
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
