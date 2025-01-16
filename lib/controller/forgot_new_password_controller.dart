// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../views/auth/password_change_successfully_page.dart';

class ForgotNewPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;

  Future<void> changePassword() async {
    final newPassword = newPasswordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('checkId');

    if (userId == null) {
      Get.snackbar("Error", "User ID not found.");
      return;
    }

    final url = Uri.parse('${baseUrl}newpassword/');
    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['password'] = newPassword
        ..fields['id'] = userId;

      final response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password changed successfully.",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() => const PasswordChangeSuccessfullyPage());
      } else {
        Get.snackbar("Failed", 'Failed to change password',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred. Please try again.");
    }
  }
}
