import 'dart:convert';
// import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/interest_accepted_model.dart';

class InterestAcceptedController extends GetxController {
  var interestAcceptList = <InterestAcceptedModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchInterestAcceptList() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "User ID not found. Please log in again.");
        isLoading.value = false;
        return;
      }

      final url = "${baseUrl}interestacceptlist/?user_id=$userId";
      // log("Fetching interest pending list from: $url");

      final token = prefs.getString('token');

      final response =
          await http.get(Uri.parse(url), headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 200) {
          final List<dynamic> data = jsonResponse['data'];
          interestAcceptList.value =
              data.map((e) => InterestAcceptedModel.fromJson(e)).toList();
        } else {
          // log("Error: ${jsonResponse['msg']}");
          // Get.snackbar("Error", jsonResponse['msg']);
        }
      } else {
        // log("Server error with status code: ${response.statusCode}");
        // Get.snackbar("Error", "Failed to fetch data from server.");
      }
    } catch (error) {
      // log("Exception occurred: $error");
      // Get.snackbar("Error", "An error occurred: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
