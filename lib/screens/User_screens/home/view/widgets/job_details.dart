import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';

class JobDetailsBottomSheet extends StatelessWidget {
  const JobDetailsBottomSheet({super.key, required this.addJobModel});

  final AddJobModel addJobModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: Text('Qualification')),
              Expanded(child: Text(':        ${addJobModel.qualification}')),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: Text('Experience')),
              Expanded(child: Text(':        ${addJobModel.experience}')),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: Text('Salary')),
              Expanded(child: Text(':        ${addJobModel.salary}')),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: Text('Job Type')),
              Expanded(child: Text(':        ${addJobModel.jobType}')),
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: Text('positions')),
              Expanded(child: Text(':        ${addJobModel.positions}')),
            ],
          ),
        ],
      ),
    );
  }
}
