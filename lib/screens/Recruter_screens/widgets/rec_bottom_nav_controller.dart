import 'package:get/get.dart';
import 'package:job_portal/screens/Recruter_screens/All_jobs/view/all_jobs.dart';
import 'package:job_portal/screens/Recruter_screens/home/view/home.dart';
import 'package:job_portal/screens/Recruter_screens/profile/view/rec_profile_screen.dart';

class RecruterBottomNavbarController extends GetxController {
  var index = 0.obs;

  final screens = [
    RecruterHomeScreen(),
    const AllJobsScreen(),
    const RecProfileScreen(),
  ];
}
