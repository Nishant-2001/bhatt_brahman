import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';

class VerificationController {
  Future<String?> fetchVerificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('childId');

    if (userId == null) {
      // log("User ID not found in SharedPreferences");
      throw Exception('User ID not found in SharedPreferences');
    }

    final token = prefs.getString("token");

    try {
      final apiUrl = "${baseUrl}verification_status?id=$userId";

      final response =
          await http.get(Uri.parse(apiUrl), headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 200) {
          return data['data']['verification_status'];
        } else {
          Get.snackbar("Error", data['msg'] ?? "Something went wrong");
          return null;
        }
      } else {
        Get.snackbar("Error", "Failed to fetch verification status");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
      return null;
    }
  }
}
