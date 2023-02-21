import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/screens/User_screens/home/view/home_screen.dart';
import 'package:job_portal/screens/User_screens/sign_in/view/sign_in.dart';
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
              return BottomNavbar();
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
}
