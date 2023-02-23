import 'package:get/get.dart';

class AddJobController extends GetxController {
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
}
