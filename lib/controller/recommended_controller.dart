import 'dart:developer';

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../model/partner_model.dart';

class RecommendedController extends GetxController {
  var partners = <PartnerModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecommendedPartners();
  }

  Future<void> fetchRecommendedPartners() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId') ?? '';

      final token = prefs.getString("token");

      final response = await http.get(
          Uri.parse('${baseUrl}matchpreferences?user_id=$userId'),
          headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // log('Response data: $data');

        if (data['status'] == 200 && data['data'] != null) {
          final matchedCustomers = data['data']['matched_customers'] as List;
          partners.value = matchedCustomers
              .map((json) => PartnerModel.fromJson(json))
              .toList();

          // log('Partners loaded: ${partners.length}');
        }
      }
    } catch (e) {
      // log('Error fetching recommended partners: $e');
    } finally {
      isLoading(false);
    }
  }

  String calculateAge(String? dob) {
    if (dob == null || dob.isEmpty || dob == '0000-00-00') return '';

    try {
      final birthDate = DateTime.parse(dob);
      final now = DateTime.now();
      var age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return '$age';
    } catch (e) {
      return '';
    }
  }
}
