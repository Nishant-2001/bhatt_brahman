import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';

class InterestedPersonController { 
  final RxSet<String> sentRequests = <String>{}.obs;

  Future<void> sendInterestRequest(String interestPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      if (sentRequests.contains(interestPersonId)) {
        Get.snackbar("Already Sent", "Interested request already sent.");
        return;
      }

      final url =
          "${baseUrl}interestsendrequest/?user_id=$userId&interest_person_id=$interestPersonId";
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
        final message = jsonResponse['msg'] ?? '';

        Get.snackbar(status == 200 ? "Success" : "Already Sent", message,
            backgroundColor: Colors.green, colorText: const Color(0xffffffff));

        if (status == 200) {
          sentRequests.add(interestPersonId);
        }
      } else {
        // Get.snackbar("Error", "Failed to send interest: ${response.body}");
      }
    } catch (e) {
      log("Exception occurred: $e");
      // Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
