import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/chat_personal_screen/model/personal_chat_model.dart';
import 'package:job_portal/screens/chat_personal_screen/view/widgets/chat_list_view.dart';
import 'package:job_portal/screens/profile_setting_screen/model/recuiter_profile_model.dart';

class UserChatPersonalScreen extends StatelessWidget {
  UserChatPersonalScreen(
      {super.key,
      required this.recruiterProfileModel,
      required this.recipentUID});

  final RecruiterProfileModel recruiterProfileModel;
  final String recipentUID;
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, size: 19),
        ),
        title: Text(
          recruiterProfileModel.companyName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.ellipsisVertical,
              size: 18,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Stack(
          children: [
            ChatListView(
              recipentUID: recipentUID,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: width * 0.02),
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message here...',
                            contentPadding: EdgeInsets.all(width * 0.03),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.cyan, width: 2.0),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.015),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.cyan.shade400,
                      child: IconButton(
                          onPressed: () async {
                            var currentUserId =
                                FirebaseAuth.instance.currentUser!.uid;
                            if (messageController.text.trim().isNotEmpty) {
                              ChatModel chatModel = ChatModel(
                                content: messageController.text.trim(),
                                sendTime: DateTime.now().toString(),
                                fromUID: currentUserId,
                                toUID: recipentUID,
                                deliveryStatus: 'send',
                              );

                              //save msg inside the recruiter id
                              await FirebaseFirestore.instance
                                  .collection('Chat')
                                  .doc(currentUserId)
                                  .collection(recipentUID)
                                  .doc(chatModel.sendTime)
                                  .set(chatModel.toJson());

                              //save msg inside the seeker id
                              await FirebaseFirestore.instance
                                  .collection('Chat')
                                  .doc(recipentUID)
                                  .collection(currentUserId)
                                  .doc(chatModel.sendTime)
                                  .set(chatModel.toJson());

                              //save msg to recentChat
                              await FirebaseFirestore.instance
                                  .collection('Chat')
                                  .doc('RecentChats')
                                  .collection(currentUserId)
                                  .doc(recipentUID)
                                  .set(chatModel.toJson());

                              await FirebaseFirestore.instance
                                  .collection('Chat')
                                  .doc('RecentChats')
                                  .collection(recipentUID)
                                  .doc(currentUserId)
                                  .set(chatModel.toJson());

                              messageController.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
