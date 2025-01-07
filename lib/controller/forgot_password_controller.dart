import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../views/auth/otp_verification_page.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var isOldPasswordVisible = true.obs;

  Future<void> sendOtp() async {
    String email = emailController.text.trim();

    try {
      var response = await http.post(
        Uri.parse('${baseUrl}send_otp/'),
        body: {
          'email': email.toLowerCase(),
        },
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);

        if (responseData['status'] == 200) {
          String checkId = responseData['data']['user_id'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('checkId', checkId);

          Get.snackbar(
              "Success", "OTP sent successfully to your registered email id.",
              backgroundColor: Colors.green, colorText: Colors.white);

          Get.to(() => const OtpVerificationPage());

          _clearFormField();
        } else {
          Get.snackbar("Failed", "Something went wrong",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Failed to send OTP. Please try again later.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void _clearFormField() {
    emailController.clear();
  }
}
