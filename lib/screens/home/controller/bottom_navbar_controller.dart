import 'package:get/get.dart';
import 'package:job_portal/screens/home/view/home_screen.dart';
import 'package:job_portal/screens/liked_jobs.dart/view/liked_jobs.dart';
import 'package:job_portal/screens/profile/view/profile_screen.dart';

class BottomNavbarController extends GetxController {
  var index = 0.obs;

  final screens = const [
    HomeScreen(),
    LikedJobs(),
    ProfileScreen(),
  ];
}
