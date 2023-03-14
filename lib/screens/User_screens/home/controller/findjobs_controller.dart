import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FindJobsController extends GetxController {
  String applyButton = 'notApplied';

  Future<void> checkUserJobApplied(String userID, String currentJobId) async {
    log('Checking if user is applied');
    var appliedUsers =
        FirebaseFirestore.instance.collection('AppliedUsers').doc(userID);
    var appliedUsersRef = await appliedUsers.get();
    if (!appliedUsersRef.exists) {
      applyButton = 'notApplied';
      log('user not applied the job');
      update();
      return;
    }
    List<dynamic> appliedJobIds = appliedUsersRef.get('appliedJobs');
    if (appliedJobIds
        .where((element) => element.toString() == currentJobId)
        .isNotEmpty) {
      log('user applied the job');
      applyButton = 'applied';
      update();
    } else {
      applyButton = 'notApplied';
      log('user not applied the job');
      update();
    }
    log('Checking if user is applied Complewted');
  }

  applyButtonClicked(String userID, String currentJobId) async {
    var appliedUsers =
        FirebaseFirestore.instance.collection('AppliedUsers').doc(userID);
    var appliedUsersSnapshot = await appliedUsers.get();
    if (appliedUsersSnapshot.exists) {
      await appliedUsers.update({
        'appliedJobs': FieldValue.arrayUnion([currentJobId])
      });
    } else {
      await appliedUsers.set({
        'appliedJobs': FieldValue.arrayUnion([currentJobId])
      });
    }

    var appliedUsersRef = await appliedUsers.get();
    List<dynamic> appliedJobIds = appliedUsersRef.get('appliedJobs');
    if (appliedJobIds
        .where((element) => element.toString() == currentJobId)
        .isNotEmpty) {
      log('user applied the job');
      applyButton = 'applied';
      update();
    } else {
      log('user not applied the job');
    }

    log('Current Applide status: $applyButton');
  }
}
