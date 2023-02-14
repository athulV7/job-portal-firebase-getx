import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';

class CompanyTab extends StatelessWidget {
  const CompanyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
            'Company Name',
            style: TextStyle(
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
                  text: 'Location,Location',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          const SizedBox(
            height: 100,
            width: 100,
            child: Material(
              child: Icon(Icons.image),
            ),
          )
        ],
      ),
    );
  }
}
