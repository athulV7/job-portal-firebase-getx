import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/core/common.dart';
import 'package:badges/badges.dart' as badges;
import 'package:job_portal/screens/chat_personal_screen/model/personal_chat_model.dart';
import 'package:job_portal/screens/chat_personal_screen/view/recruiter_chat_personal_screen.dart';
import 'package:job_portal/screens/chat_personal_screen/view/user_chat_personal_screen.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';
import 'package:job_portal/screens/profile_setting_screen/model/seeker_profile_model.dart';
import 'package:shimmer/shimmer.dart';

class ChatFrontScreen extends StatelessWidget {
  const ChatFrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(width * 0.25),
        child: AppBar(
          backgroundColor: Colors.cyan.withOpacity(0.8),
          title: Padding(
            padding: EdgeInsets.only(top: width * 0.06),
            child: Text(
              'Chat',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(top: width * 0.04),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.cyan.withOpacity(0.8),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chat')
                .doc('RecentChats')
                .collection(currentUserID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var chatPersonsList = snapshot.data!.docs;
              if (chatPersonsList.isEmpty) {
                return const Center(
                  child: Text(
                    'No Chats',
                    style: subHeadingNormal,
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.only(top: width * 0.08),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
                itemCount: chatPersonsList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(chatPersonsList[index].id)
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                          baseColor: Colors.white,
                          highlightColor: Colors.grey,
                          child: chatTileShimmers(),
                        );
                      }
                      String name;
                      log('role :${snapshot.data!.data()!['role']}');
                      if (snapshot.data!.data()!['role'] == 'seeker') {
                        name = snapshot.data!.data()!['profile']['name'];
                      } else {
                        name = snapshot.data!.data()!['profile']['companyName'];
                      }

                      ChatModel chatModel =
                          ChatModel.fromJson(chatPersonsList[index].data());

                      //checking the message send time is today or not
                      String formatedTime = getChatTileTime(chatModel);

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                        child: InkWell(
                          onTap: () async {
                            var recipentDoc = await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(chatPersonsList[index].id)
                                .get();
                            if (recipentDoc.data()!['role'] == 'seeker') {
                              log('seeker');
                              ProfileSettingModel profileSettingModel =
                                  ProfileSettingModel.fromJson(
                                recipentDoc.data()!['profile'],
                              );

                              Get.to(
                                RecruiterChatPersonalScreen(
                                    profileSettingModel: profileSettingModel,
                                    recipentUID: chatPersonsList[index].id),
                              );
                            } else {
                              RecruiterProfileModel recruiterProfileModel =
                                  RecruiterProfileModel.fromJson(
                                recipentDoc.data()!['profile'],
                              );

                              Get.to(
                                UserChatPersonalScreen(
                                    recruiterProfileModel:
                                        recruiterProfileModel,
                                    recipentUID: chatPersonsList[index].id),
                              );
                            }
                          },
                          child: Material(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 26,
                                    backgroundImage: AssetImage(
                                        'assets/images/_anonymous-profile-grey-person-sticker-glitch-empty-profile.png'),
                                  ),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: width * 0.01),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            chatModel.content,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: width * 0.021),
                                        child: Text(
                                          formatedTime,
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ),
                                      badges.Badge(
                                        badgeContent: const Text(
                                          '3',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        badgeStyle: badges.BadgeStyle(
                                          badgeColor: Colors.cyan.shade300,
                                          padding:
                                              EdgeInsets.all(width * 0.015),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  //:::::::::::::::::::::::::::::::::--------------------::::::::::::::::::
  //checking the message sending time is today or not ..
  //if today it will return time, else return the date

  String getChatTileTime(ChatModel chatModel) {
    List<String> monthList = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    DateTime dateTime = DateTime.parse(chatModel.sendTime);
    DateTime dateTimeToday = DateTime.now();
    if (dateTime.year == dateTimeToday.year &&
        dateTime.month == dateTimeToday.month &&
        dateTime.day == dateTimeToday.day) {
      return DateFormat("h:mm a").format(dateTime);
      // if (dateTime.hour > 12) {
      //   return '${dateTime.hour - 12} : ${dateTime.minute} PM';
      // } else {
      //   return '${dateTime.hour}:${dateTime.minute} AM';
      // }
    } else if (dateTime.year == dateTimeToday.year &&
        dateTime.month == dateTimeToday.month &&
        dateTime.day == dateTimeToday.day - 1) {
      return 'yesterday';
    } else if (dateTime.year == dateTimeToday.year) {
      String month = monthList[dateTime.month - 1];
      return '$month-${dateTime.day}';
    } else {
      String month = monthList[dateTime.month - 1];
      return '${dateTime.year}-$month-${dateTime.day}';
    }
  }

  //shimmers for chat Tile
  Widget chatTileShimmers() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.06),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            children: [
              const CircleAvatar(radius: 26),
              SizedBox(width: width * 0.04),
              Padding(
                padding: EdgeInsets.only(top: width * 0.01),
                child: Column(
                  children: [
                    const Text(''),
                    SizedBox(height: height * 0.006),
                    const Text('')
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.01),
                    child: const Text(''),
                  ),
                  badges.Badge(
                    badgeContent: const Text(
                      '3',
                    ),
                    badgeStyle: badges.BadgeStyle(
                        padding: EdgeInsets.all(width * 0.016)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
