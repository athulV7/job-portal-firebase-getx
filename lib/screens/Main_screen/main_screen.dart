import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/screens/Recruter_screens/widgets/recruter_bottom_nav.dart';
import 'package:job_portal/screens/Role_select_screen/view/role_section_scr.dart';
import 'package:job_portal/screens/sign_in/view/sign_in.dart';
import 'package:job_portal/widgets/bottom_nav.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              log('auth stream has data');
              return FutureBuilder(
                  future: isRoleExist(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      log('isRoleExists Completed');
                      if (snapshot.data == 'noRole') {
                        return RoleSelectionScreen();
                      } else if (snapshot.data == 'seeker') {
                        return BottomNavbar();
                      } else {
                        return RecruterBottomNavbar();
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!!'),
              );
            } else {
              return SignIn();
            }
          },
        ),
      );

  Future<String> isRoleExist() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    var docSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(userUID).get();
    if (docSnapshot.data() != null) {
      String? role = docSnapshot.data()!['role'];
      return role ?? 'noRole';
    }

    return 'noRole';
  }
}
