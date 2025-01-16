import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationItem>[].obs;
  var isLoading = false.obs;

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found in SharedPreferences');
      }

      final url = '${baseUrl}notification_list?user_id=$userId';
      // log('Fetching notifications from URL: $url');

      final token = prefs.getString("token");

      final response =
          await http.get(Uri.parse(url), headers: {'token': "$token"});
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = NotificationModel.fromJson(json.decode(response.body));
        notifications.value = data.notifications;
      } else {
        final errorMsg = json.decode(response.body)['msg'] ?? 'Unknown error';
        throw Exception('API Error: $errorMsg');
      }
    } catch (e) {
      log('Error: $e');
      // Get.snackbar('Error', "Something went wrong",
      //     backgroundColor: Colors.red, colorText: const Color(0xffffffff));
    } finally {
      isLoading.value = false;
    }
  }

  Future<int> fetchNotificationCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found in SharedPreferences');
      }

      final token = prefs.getString("token");

      final response = await http.get(
          Uri.parse(
            "${baseUrl}notification_countes?user_id=$userId",
          ),
          headers: {"token": "$token"});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['viewed_count'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<void> removeNotificationBadge() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '';

      if (userId.isEmpty) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      final url = Uri.parse("${baseUrl}notificationremove");

      final token = prefs.getString('token');

      final response = await http.post(url, headers: {
        "token": "$token"
      }, body: {
        "user_id": userId,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 200) {}
      } else {}
    } catch (e) {
      // log("");
    }
  }
}
