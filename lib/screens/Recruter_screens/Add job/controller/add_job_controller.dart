import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddJobController extends GetxController {
  final formKeyJob = GlobalKey<FormState>();
  final positionsController = TextEditingController();
  String? selectedIndex;
  String? selectedOption;

  jobTypeButton(String? value) {
    selectedIndex = value;
    update();
  }

  industryTypeButton(String? value) {
    selectedOption = value;
    update();
  }

  positionsAddButtonClicked() {
    int positions;
    if (positionsController.text.isEmpty) {
      positions = 1;
    } else {
      positions = int.parse(positionsController.text);
      positions++;
    }

    positionsController.text = positions.toString();
    update();
  }
}
