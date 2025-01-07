import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/login_response_model.dart';
import '../views/home/home_page.dart';

class SignInController extends GetxController {
  var isPasswordVisible = true.obs;
  var isLoading = false.obs;
  var isRememberMe = false.obs;  

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var emailError = ''.obs;
  var passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedCredentials();  
  }

  
  Future<void> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberedEmail = prefs.getString('remembered_email');
    final rememberedPassword = prefs.getString('remembered_password');
    final wasRemembered = prefs.getBool('was_remembered') ?? false;

    if (wasRemembered && rememberedEmail != null && rememberedPassword != null) {
      emailController.text = rememberedEmail;
      passwordController.text = rememberedPassword;
      isRememberMe.value = true;
    }
  }

 
  Future<void> saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (isRememberMe.value) {
      await prefs.setString('remembered_email', emailController.text);
      await prefs.setString('remembered_password', passwordController.text);
      await prefs.setBool('was_remembered', true);
    } else {
      await prefs.remove('remembered_email');
      await prefs.remove('remembered_password');
      await prefs.setBool('was_remembered', false);
    }
  }

  Future<void> loginUser() async {
    emailError.value = '';
    passwordError.value = '';
    isLoading.value = true;

    try {
      var url = Uri.parse("${baseUrl}login");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': emailController.text.trim().toLowerCase(),
          'password': passwordController.text.trim(),
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse['status'] == 200) {
        final loginResponse = LoginResponseModel.fromJson(jsonResponse['data']);

        String? childId;
        if (jsonResponse['data']['customers'] != null &&
            jsonResponse['data']['customers'].isNotEmpty) {
          childId = jsonResponse['data']['customers'][0]['child_id'];
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (loginResponse.token != null) {
          await prefs.setString('token', loginResponse.token!);
        }

        await prefs.setString('parent', jsonEncode(loginResponse.parent.toJson()));
        await prefs.setString('userId', loginResponse.parent.loginId.toString());

        if (childId != null) {
          await prefs.setString('childId', childId);
        }

        await prefs.setBool('is_logged_in', true);

        
        await saveCredentials();

        
        if (!isRememberMe.value) {
          _clearFormFields();
        }

        Get.snackbar("Success", "Login Successfully",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);

        Get.offAll(() => const HomePage());
      } else {
        if (jsonResponse['msg'] == 'Invalid password') {
          passwordError.value = 'Invalid password. Please try again.';
        } else if (jsonResponse['msg'] == 'Email not found') {
          emailError.value = 'Email address not found.';
        } else {
          Get.snackbar('Failed', jsonResponse['msg'],
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              colorText: const Color.fromARGB(255, 224, 17, 17));
        }
      }
    } catch (e) {
      Get.snackbar('Failed', 'Something went wrong: $e',
          backgroundColor: const Color.fromARGB(255, 170, 36, 2),
          colorText: const Color(0xffffffff),
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<Parent?> getParentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? parentData = prefs.getString('parent');
    if (parentData != null) {
      return Parent.fromJson(jsonDecode(parentData));
    }
    return null;
  }

  Future<String?> getParentContactNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? parentData = prefs.getString('parent');
    if (parentData != null) {
      final parent = Parent.fromJson(jsonDecode(parentData));
      return parent.contact;
    }
    return null;
  }

  void _clearFormFields() {
    emailController.clear();
    passwordController.clear();
  }

  
  Future<void> clearRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remembered_email');
    await prefs.remove('remembered_password');
    await prefs.setBool('was_remembered', false);
  }
}