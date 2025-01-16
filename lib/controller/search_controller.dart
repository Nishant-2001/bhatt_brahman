import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/partner_model.dart';

class SearchController extends GetxController {
  final TextEditingController minHeight = TextEditingController();
  final TextEditingController maxHeight = TextEditingController();
  final TextEditingController minAge = TextEditingController();
  final TextEditingController maxAge = TextEditingController();

  var isLoading = false.obs;

  String? bodyType;
  String? skinComplexion;
  String? maritalStatus;
  String? education;
  String? profession;
  String? location;

  Future<List<PartnerModel>> fetchPartners() async {
    isLoading.value = true;

    try {
      if (isAnyFieldFilled()) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userId = prefs.getString('childId');

        if (userId == null) {
          throw Exception('User ID not found in SharedPreferences');
        }

        var url = Uri.parse(
          '${baseUrl}searchpartnerlist'
          '?user_id=$userId'
          '&min_height=${minHeight.text.trim()}'
          '&max_height=${maxHeight.text.trim()}'
          '&min_age=${minAge.text.trim()}'
          '&max_age=${maxAge.text.trim()}'
          '&body_type=${bodyType ?? ''}'
          '&skin_complexion=${skinComplexion ?? ''}'
          '&lives_in=${location ?? ''}'
          '&profession=${profession ?? ''}'
          '&education=${education ?? ''}',
        );

        final token = prefs.getString("token");

        final response = await http.get(url, headers: {'token': '$token'});

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          if (responseData['status'] == 200) {
            final List<dynamic> data = responseData['data'] ?? [];
            return data.map((json) => PartnerModel.fromJson(json)).toList();
          } else {
            throw Exception(responseData['msg'] ?? 'Unknown error');
          }
        } else {
          throw Exception(
              'Failed to load partners (Status: ${response.statusCode})');
        }
      } else {
        
        if (Get.isSnackbarOpen == false) {
          
          Get.snackbar(
            'Field Required',
            'Please fill at least one search field.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
        return [];
        
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  bool isAnyFieldFilled() {
    return minHeight.text.trim().isNotEmpty ||
        maxHeight.text.trim().isNotEmpty ||
        minAge.text.trim().isNotEmpty ||
        maxAge.text.trim().isNotEmpty ||
        bodyType != null && bodyType!.trim().isNotEmpty ||
        skinComplexion != null && skinComplexion!.trim().isNotEmpty ||
        location != null && location!.trim().isNotEmpty ||
        profession != null && profession!.trim().isNotEmpty ||
        education != null && education!.trim().isNotEmpty;
  }
}
