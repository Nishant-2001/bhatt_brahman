import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../views/home/home_page.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var isOldPasswordVisible = true.obs;

  Future<void> changePassword() async {
    // Retrieve the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final loginId = prefs.getString('userId');

    if (token == null || token.isEmpty) {
      Get.snackbar("Error", "Token not found");
      return;
    }

    const String url = '${baseUrl}changepassword';

    final request = http.MultipartRequest('POST', Uri.parse(url))
      ..headers['token'] = token
      ..fields['id'] = '$loginId'
      ..fields['old_password'] = currentPasswordController.text
      ..fields['new_password'] = newPasswordController.text;

    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Check the 'status' key instead of 'success'
        if (responseData['status'] == 200) {
          Get.off(() => const HomePage());
          Get.snackbar(
              "Success", responseData['msg'] ?? "Password changed successfully",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);

          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        } else {
          Get.snackbar(
              "Error", responseData['msg'] ?? "Failed to change password",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}
