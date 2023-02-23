import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/controller/add_job_controller.dart';

class IndustryDropDown extends StatelessWidget {
  IndustryDropDown({super.key});

  final addjobController = Get.put(AddJobController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddJobController>(
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(18),
        ),
        child: DropdownButton(
          isExpanded: true,
          hint: const Text('Industry'),
          value: addjobController.selectedOption,
          onChanged: (newValue) {
            addjobController.industryTypeButton(newValue);
          },
          items: const [
            DropdownMenuItem(
              value: 'Busienss',
              child: Text('Busienss'),
            ),
            DropdownMenuItem(
              value: 'Information Technology',
              child: Text('Information Technology'),
            ),
            DropdownMenuItem(
              value: 'Banking',
              child: Text('Banking'),
            ),
            DropdownMenuItem(
              value: 'Education/Training',
              child: Text('Education/Training'),
            ),
            DropdownMenuItem(
              value: 'Telecommunication',
              child: Text('Telecommunication'),
            ),
            DropdownMenuItem(
              value: 'Engineering',
              child: Text('Engineering'),
            ),
            DropdownMenuItem(
              value: 'Health',
              child: Text('Health'),
            ),
            DropdownMenuItem(
              value: 'Media',
              child: Text('Media'),
            ),
            DropdownMenuItem(
              value: 'Others',
              child: Text('Others'),
            ),
          ],
        ),
      ),
    );
  }
}
