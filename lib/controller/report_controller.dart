import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class ReportController extends GetxController {
  TextEditingController descriptionController = TextEditingController();

  Future<void> sendReportRequest(personId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final url = Uri.parse("${baseUrl}report/");

      final token = prefs.getString('token');

      final response = await http.post(url, headers: {
        "token": "$token"
      }, body: {
        "user_id": userId,
        "person_id": personId,
        "description": descriptionController.text.trim()
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final msg = responseData["msg"] ?? '';

        if (responseData["status"] == 200) {
          descriptionController.clear();
          Get.snackbar("Success", msg,
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Failed", "Failed to Report ",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log("Log ------ $e");
    }
  }
}
