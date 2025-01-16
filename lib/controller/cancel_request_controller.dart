import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class CancelRequestController {
  final RxSet<String> cancelRequests = <String>{}.obs;

  Future<void> sendCancelRequest(interestPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      if (cancelRequests.contains(interestPersonId)) {
        Get.snackbar("Already Cancel", "Cancel request already sent.");
        return;
      }

      final url =
          "${baseUrl}interestcanncelrequest/?user_id=$userId&interest_person_id=$interestPersonId";

      // log("Sending POST request to URL: $url");

      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'token': '$token'
        },
        body: {
          "user_id": userId,
          "interest_person_id": interestPersonId,
        },
      );

      // log("Response Status Code: ${response.statusCode}");
      // log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final status = jsonResponse['status'];
        final message = jsonResponse['msg'] ?? 'Unknown response';

        Get.snackbar(
          status == 200 ? "Success" : "Cancel",
          message,
          // 'Already Cancelled Request',
          backgroundColor: Colors.green,
        );

        if (status == 200) {
          cancelRequests.add(interestPersonId);
        }
      } else {
        Get.snackbar("Error", "Failed to cancel interest: ${response.body}");
      }
    } catch (e) {
      // log("Exception occurred: $e");
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
