import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/chat_personal_screen/model/personal_chat_model.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({Key? key, required this.recipentUID}) : super(key: key);
  final String recipentUID;
  @override
  Widget build(BuildContext context) {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .doc(currentUserID)
          .collection(recipentUID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var messageDoc = snapshot.data!.docs[index];
            ChatModel chatModel = ChatModel.fromJson(messageDoc.data());
            DateTime time = DateTime.parse(chatModel.sendTime);
            final formatedTime = DateFormat("h:mm a").format(time);
            return UnconstrainedBox(
              alignment: chatModel.fromUID == recipentUID
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                constraints: BoxConstraints(maxWidth: width / 1.5),
                child: Card(
                  color: chatModel.fromUID == recipentUID
                      ? Colors.white
                      : Colors.cyan.shade300,
                  shape: chatModel.fromUID == recipentUID
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        )
                      : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.023),
                    child: Column(
                      children: [
                        Text(
                          chatModel.content,
                          style: TextStyle(
                            fontSize: 14,
                            color: chatModel.fromUID == recipentUID
                                ? Colors.cyan.shade600
                                : Colors.white,
                          ),
                        ),
                        // Text(
                        //   formatedTime,
                        // ),
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
  }
}
