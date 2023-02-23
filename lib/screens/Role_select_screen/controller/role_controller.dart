import 'package:get/get.dart';

class RoleController extends GetxController {
  double elevation1 = 0;
  double elevation2 = 0;
  bool checkVisibility1 = false;
  bool checkVisibility2 = false;
  int selected = 0;

  seekerButtonTap() {
    elevation1 = 3;
    elevation2 = 0;
    checkVisibility1 = true;
    checkVisibility2 = false;
    selected = 1;
    update();
  }

  recruterButtonTap() {
    elevation1 = 0;
    elevation2 = 3;
    checkVisibility1 = false;
    checkVisibility2 = true;
    selected = 2;
    update();
  }
}
