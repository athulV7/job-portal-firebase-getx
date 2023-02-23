import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/controller/add_job_controller.dart';

class JobTypeDropDown extends StatelessWidget {
  JobTypeDropDown({
    Key? key,
  }) : super(key: key);

  final addJobController = Get.put(AddJobController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddJobController>(
      builder: (controller) => DropdownButton(
        hint: const Text('Job Type'),
        value: addJobController.selectedIndex,
        onChanged: (newValue) {
          addJobController.jobTypeButton(newValue);
        },
        items: const [
          DropdownMenuItem(
            value: 'Full-Time',
            child: Text('Full-Time'),
          ),
          DropdownMenuItem(
            value: 'Part-Time',
            child: Text('Part-Time'),
          ),
          DropdownMenuItem(
            value: 'Remote',
            child: Text('Remote'),
          ),
        ],
      ),
    );
  }
}
