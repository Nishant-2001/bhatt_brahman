import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class AcceptRequestController {
  final RxSet<String> rejectRequests = <String>{}.obs;

  Future<void> sendAcceptRequest(interestPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      if (rejectRequests.contains(interestPersonId)) {
        Get.snackbar("Already Sent", "Not Interested request already sent.");
        return;
      }

      final url =
          "${baseUrl}interestacceptrequest/?user_id=$interestPersonId&interest_person_id=$userId";
      String? token = prefs.getString("token");

      // log("Sending POST request to URL: $url");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'token': '$token'
        },
        body: {
          "user_id": interestPersonId,
          "interest_person_id": userId,
        },
      );

      // log("Response Status Code: ${response.statusCode}");
      // log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final status = jsonResponse['status'];
        final message = jsonResponse['msg'] ?? '';

        Get.snackbar(status == 200 ? "Success" : "Error", message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);

        if (status == 200) {
          rejectRequests.add(userId);
        }
      } else {
        Get.snackbar("Failed", "Failed to send interest",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      // log("Exception occurred: $e");
      Get.snackbar("Error", "An error occurred",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
