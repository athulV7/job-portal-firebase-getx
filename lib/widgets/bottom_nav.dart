import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/User_screens/home/controller/bottom_navbar_controller.dart';

class BottomNavbar extends GetView<BottomNavbarController> {
  BottomNavbar({super.key});

  final bottomNavController = Get.put(BottomNavbarController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: bottomNavController.screens[bottomNavController.index.value],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            bottomNavController.index.value = value;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.cyan,
          currentIndex: bottomNavController.index.value,
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
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Liked',
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
