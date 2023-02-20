import 'package:get/get.dart';
import 'package:job_portal/screens/User_screens/Find_jobs/view/find_jobs.dart';
import 'package:job_portal/screens/User_screens/home/view/home_screen.dart';
import 'package:job_portal/screens/User_screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:job_portal/screens/User_screens/profile/view/profile_screen.dart';

class BottomNavbarController extends GetxController {
  var index = 0.obs;

  final screens = const [
    HomeScreen(),
    FindJobs(),
    LikedJobs(),
    ProfileScreen(),
  ];
}
