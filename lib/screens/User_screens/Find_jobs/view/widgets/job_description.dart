import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';

class JobDescription extends StatelessWidget {
  const JobDescription({super.key, required this.addJobModel});

  final AddJobModel addJobModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Job Description',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(addJobModel.description),
        ],
      ),
    );
  }
}
