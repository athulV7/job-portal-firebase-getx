import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';

class JobDescription extends StatelessWidget {
  const JobDescription({super.key});

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
          const Text(
              """Ready to help unleash the power of teams across the globe?
    We're looking for a Product Designer to join our Cloud Security team. Jira Software, Jira Service Management, Confluence, and Bitbucket Data Center are Atlassian’s on-premise offers used by our largest and most complex customers."""),
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
            'Responsibilities',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          const Text(
              """Work on projects across all our Cloud products Harness your product design skills to help streamline the critical experience for our users."""),
        ],
      ),
    );
  }
}
