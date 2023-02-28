import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';
import 'package:job_portal/screens/Recruter_screens/Add%20job/model/add_job_model.dart';

class CompanyTab extends StatelessWidget {
  const CompanyTab({super.key, required this.addJobModel});

  final AddJobModel addJobModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            addJobModel.companyName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 19,
                    color: Colors.green.shade200,
                  ),
                ),
                TextSpan(
                  text: addJobModel.location,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
