import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final searchController = TextEditingController();

  listenSearchController() {
    searchController.addListener(() {
      update();
    });
  }
}
