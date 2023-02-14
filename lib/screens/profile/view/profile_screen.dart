import 'package:flutter/material.dart';
import 'package:job_portal/core/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        right: width * 0.03,
        left: width * 0.03,
        //bottom: width * 0.03,
        top: width * 0.26,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: height * 0.2,
                margin: EdgeInsets.only(top: width * 0.19),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.cyan.withOpacity(0.1),
                ),
                child: const Center(
                  child: Text('Name'),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade400,
                  child: const Icon(
                    Icons.account_circle,
                    size: 120,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: height * 0.3,
              margin: EdgeInsets.only(top: width * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.cyan.withOpacity(0.1),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: height * 0.08,
                    margin: EdgeInsets.all(width * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: height * 0.08,
                      margin: EdgeInsets.only(
                        left: width * 0.02,
                        right: width * 0.02,
                        //bottom: width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
