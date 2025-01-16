import 'dart:convert';
// import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/expressed_interest_model.dart';

class ExpressedInterestController extends GetxController {
  var interestExpressedList = <ExpressedInterestModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchExpressedInterestList() async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "User ID not found. Please log in again.");
        isLoading.value = false;
        return;
      }

      final url = "${baseUrl}interestreceivelist/?interest_person_id=$userId";
      // log("Fetching Expressed interest list from: $url");

      final token = prefs.getString('token');


      final response = await http.get(Uri.parse(url), headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 200) {
          final List<dynamic> data = jsonResponse['data'];
          interestExpressedList.value =
              data.map((e) => ExpressedInterestModel.fromJson(e)).toList();
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
