import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/Recruter_screens/widgets/rec_bottom_nav_controller.dart';

class RecruterBottomNavbar extends GetView<RecruterBottomNavbarController> {
  RecruterBottomNavbar({super.key});

  final recBottomNavController = Get.put(RecruterBottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body:
            recBottomNavController.screens[recBottomNavController.index.value],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            recBottomNavController.index.value = value;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.cyan,
          currentIndex: recBottomNavController.index.value,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
