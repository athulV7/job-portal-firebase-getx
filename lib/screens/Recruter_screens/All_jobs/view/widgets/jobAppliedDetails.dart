import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobAppliedDetails extends StatelessWidget {
  const JobAppliedDetails({super.key, required this.currentJobId});

  final currentJobId;

  @override
  Widget build(BuildContext context) {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        body: FutureBuilder(
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
              List<dynamic> seekersUIDList = snapshot.data!.get('applied');
              return ListView.builder(
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
                          String email = snapshot.data!.get('Auth')['email'];
                          return ListTile(
                            leading: Card(
                              child: Text(email),
                            ),
                          );
                        });
                  });
            }));
  }
}
