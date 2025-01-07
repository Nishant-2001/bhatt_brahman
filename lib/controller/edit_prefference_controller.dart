import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../constants/instance.dart';
import '../model/prefferences_model.dart';
import '../views/home/home_page.dart';
import '../views/pages/profile_page.dart';

class EditPrefferenceController {
  TextEditingController preferMinAgeController = TextEditingController();
  TextEditingController preferMaxAgeController = TextEditingController();
  TextEditingController preferMinHeightController = TextEditingController();
  TextEditingController preferMaxHeightController = TextEditingController();
  // TextEditingController preferLocationController = TextEditingController();

  String? selectedMaritalStatus;
  String? selectedMaritalStatusId;
  String? selectedBodyType;
  String? selectedSkinComplextion;
  String? selectedEducation;
  String? selectedProfession;
  String? selectedLocation;

  String? userId;

  EditPrefferenceController() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      userId = prefs.getString('childId');
      log('[Debug] Loaded User ID: $userId');

      final allKeys = prefs.getKeys();
      log('[Debug] All SharedPreferences keys: $allKeys');
    } catch (e) {
      log('[Error] Failed to load User ID from SharedPreferences: $e');
    }
  }

  Future<void> loadPreferenceData() async {
    PrefferencesModel? prefferences =
        await prefferencesController.fetchUserPreferences();

    preferMinAgeController.text = prefferences?.minAge ?? "";
    preferMaxAgeController.text = prefferences?.maxAge ?? "";
    preferMinHeightController.text = prefferences?.minHeight ?? "";
    preferMaxHeightController.text = prefferences?.maxHeight ?? "";

    selectedMaritalStatusId = prefferences?.maritalStatusId ?? "";
    selectedBodyType = prefferences?.bodyTypeId ?? "";
    selectedSkinComplextion = prefferences?.skinComplexionId ?? "";
    selectedEducation = prefferences?.educationId ?? "";
    selectedProfession = prefferences?.professionId ?? "";
    selectedLocation = prefferences?.livesInId ?? "";
  }

  Future<bool> updatePrefferenceData(BuildContext context) async {
    if (userId == null) {
      await _loadUserId();
      if (userId == null) {
        _showErrorSnackBar(context, 'User ID not found');
        return false;
      }
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    if (token == null) {
      _showErrorSnackBar(context, 'Token not found');
      return false;
    }

    try {
      final url = Uri.parse("${baseUrl}preferences");
      // log('[Debug] Making request to URL: $url');

      final request = http.MultipartRequest(
        'POST',
        url,
      );

      request.headers.addAll({
        'token': token,
        'Content-Type': 'application/json',
      });

      final fields = {
        "user_id": userId!,
        "marital_status": selectedMaritalStatusId ?? "",
        "min_age": preferMinAgeController.text,
        "max_age": preferMaxAgeController.text,
        "min_height": preferMinHeightController.text,
        "max_height": preferMaxHeightController.text,
        "body_type": selectedBodyType ?? "",
        "skin_complexion": selectedSkinComplextion ?? "",
        "education": selectedEducation ?? "",
        "profession": selectedProfession ?? "",
        "lives_in": selectedLocation ?? "",
      };

      request.fields.addAll(fields);

      // log('[Debug] Request fields: ${json.encode(fields)}');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // log('[Response] Status Code: ${response.statusCode}');
      // log('[Response] Body: $responseBody');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(responseBody);

        if (jsonResponse['status'] == 200) {
          Get.snackbar("Success", "Preference Updated Successfully",
              backgroundColor: Colors.green, colorText: Colors.white);

          Get.offAll(() => const HomePage());

          preferMinAgeController.clear();
          preferMaxAgeController.clear();
          preferMinHeightController.clear();
          preferMaxHeightController.clear();

          
          selectedMaritalStatus = null;
          selectedMaritalStatusId = null;
          selectedBodyType = null;
          selectedSkinComplextion = null;
          selectedEducation = null;
          selectedProfession = null;
          selectedLocation = null;

          return true;
        } else {
          Get.snackbar("Failed", "Preference Updated Failed",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);

          return false;
        }
      } else {
        Get.snackbar("Failed", "Preference Updated Failed",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return false;
      }
    } catch (e) {
      log('[Exception] Error updating preference: $e');
      Get.snackbar("Failed", "An error occurred while updating preference",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      return false;
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void dispose() {
    preferMinAgeController.dispose();
    preferMaxAgeController.dispose();
    preferMinHeightController.dispose();
    preferMaxHeightController.dispose();
  }
}
