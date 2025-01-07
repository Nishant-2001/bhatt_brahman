import 'dart:convert';
import 'dart:developer';
// item.userId
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class NotInterestedPersonController {
  final RxSet<String> rejectRequests = <String>{}.obs;

  Future<void> sendRejectRequest(interestPersonId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      if (rejectRequests.contains(interestPersonId)) {
        Get.snackbar("Already Sent", "Not Interested request already sent.");
        return;
      }

      final token = prefs.getString("token");

      final url =
          "${baseUrl}interestrejectrequest/?user_id=$interestPersonId&interest_person_id=$userId";

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
        final message = jsonResponse['msg'] ?? 'Unknown response';

        Get.snackbar(
          status == 200 ? "Success" : "Error",
          message,
        );

        if (status == 200) {
          rejectRequests.add(userId);
        }
      } else {
        Get.snackbar("Error", "Failed to send interest: ${response.body}");
      }
    } catch (e) {
      // log("Exception occurred: $e");
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
