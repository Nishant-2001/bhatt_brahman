import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../views/auth/new_password_forgot_page.dart';

class OtpVerificationController extends GetxController {
  Future<void> verifyOtp(String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('checkId');
      if (userId == null) {
        log("userId ----------- $userId");
        Get.snackbar("Error", "User ID not found. Please log in again.");
        return;
      }

      final response = await http.post(
        Uri.parse('${baseUrl}check_otp/'),
        body: {
          'user_id': userId,
          'otp': otp,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['data']['otp_status'] == 'valid') {
        Get.snackbar("Success", "OTP verified successfully.",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.to(() =>  NewPasswordForgotPage());
      } else {
        Get.snackbar("Error", "OTP verification failed.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      log("Error during OTP verification");
      Get.snackbar("Error", "Something went wrong. Please try again.");
    }
  }
}
