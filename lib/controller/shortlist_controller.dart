import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/Shortlisted_model.dart';

class ShortlistController extends GetxController {
  Future<void> sendShortlistRequest(interestedPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final url = Uri.parse("${baseUrl}send_shortlist");
      final token = prefs.getString('token');

      final response = await http.post(url, headers: {
        "token": "$token"
      }, body: {
        "user_id": userId,
        "interest_person_id": interestedPersonId,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final msg = responseData["msg"] ?? '';
        if (responseData['status'] == 200) {
          Get.snackbar("Success", msg,
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Failed", "Failed to shortlist ",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // log("loooog ----- $e");
    }
  }
  
  Future<void> removeShortlistedProfile(interestedPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final url = Uri.parse("${baseUrl}cancel_shortlist");
      final token = prefs.getString('token');

      final response = await http.post(url, headers: {
        "token": "$token"
      }, body: {
        "user_id": userId,
        "interest_person_id": interestedPersonId,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final msg = responseData["msg"] ?? '';
        if (responseData['status'] == 200) {
          Get.snackbar("Success", msg,
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Failed", "Failed to shortlist ",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // log("log ----- $e");
    }
  }



  Future<List<ShortlistedModel>> fetchShortlistData() async {
    List<ShortlistedModel> interests = [];

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
      }

      final url = Uri.parse("${baseUrl}interest_shortlist?user_id=$userId");

      final token = prefs.getString('token'); 

      final response = await http.get(url, headers: {"token": "$token"});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] != 200) {
          return interests;
        }

        final List<dynamic> list = data['data'];
        // log("Fetched list: $list");
        interests = list.map((e) => ShortlistedModel.fromJson(e)).toList();
      } else {}
    } catch (e) {
      // log("Log ----------- $e");
    }
    return interests;
  }
}
