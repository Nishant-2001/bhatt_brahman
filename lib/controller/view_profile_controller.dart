import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/viewed_profile_model.dart';

class ViewProfileController extends GetxController {
  Future<void> openProfilePage(personId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final url = "${baseUrl}openprofile?user_id=$userId&person_id=$personId";

      String? token = prefs.getString("token");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'token': '$token'
        },
        body: {
          "user_id": userId,
          "person_id": personId,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      } else {}
    } catch (e) {
      log("Exception occurred: $e");
    }
  }

  Future<ViewedProfileResponse> fetchProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('childId') ?? '';

    if (userId.isEmpty) {
      Get.snackbar("Error", "User ID not found");
    }

    final url = Uri.parse("${baseUrl}viewprofile?person_id=$userId");

    String? token = prefs.getString("token");

    try {
      final response = await http.get(url, headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ViewedProfileResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load profiles');
      }
    } catch (e) {
      throw Exception('Error fetching profiles: $e');
    }
  }
}
