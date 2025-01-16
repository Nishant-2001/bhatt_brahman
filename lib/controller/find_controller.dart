import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/partner_model.dart';

class FindController extends GetxController {
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('childId');

      if (userId == null) {
        // log("User ID not found in SharedPreferences");
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

      // log('[URL]: $url');

      final token = prefs.getString("token");

      final response = await http.get(url, headers: {'token': '$token'});
      // log('[Response]: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 200) {
          final List<dynamic> data = responseData['data'] ?? [];
          // log('Data received successfully. Total records: ${data.length}');
          return data.map((json) => PartnerModel.fromJson(json)).toList();
        } else {
          // log('API Message: ${responseData['msg']}');
          throw Exception(responseData['msg'] ?? 'Unknown error');
        }
      } else {
        throw Exception(
            'Failed to load partners (Status: ${response.statusCode})');
      }
    } catch (e) {
      // log('Error fetching partners: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
