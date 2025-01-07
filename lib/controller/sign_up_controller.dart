import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../views/auth/sign_in_page.dart';

class SignUpController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  var isLoading = false.obs;

  Future<bool> signUpForm() async {
    isLoading.value = true;

    try {
      var url = Uri.parse("${baseUrl}register");

      var request = http.MultipartRequest('POST', url)
        ..fields['first_name'] = firstNameController.text
        ..fields['last_name'] = lastNameController.text
        ..fields['contact'] = contactController.text.trim()
        ..fields['email'] = emailController.text.trim()
        ..fields['password'] = passwordController.text;

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      log("Response Data: $responseData");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseData);
        if (jsonResponse['status'] == 200) {
          String token = jsonResponse['data']['token'];

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          log("Token saved: $token");

          _clearFormFields();

          Get.snackbar("Success", "Registered Successfully",

              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green);
          Get.offAll(() => const SignInPage());

          return true;
        } else if (jsonResponse['status'] == 400) {
          Get.snackbar(
            "Error",
            jsonResponse['message'] ?? "User already exists",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return false;
    } catch (e) {
      log('Error: $e');
      Get.snackbar(
        "Error",
        "An error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _clearFormFields() {
    firstNameController.clear();
    lastNameController.clear();
    contactController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
