import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';
import '../model/profile_response_model.dart';

class ProfileController {
  Future<ProfileResponseModel> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('childId');

    if (userId == null) {
      throw Exception('User ID not found in SharedPreferences');
    }

    final token = prefs.getString("token");
    final url = Uri.parse(
      '${baseUrl}edit_profile?id=$userId',
    );
    final response = await http.get(url, headers: {'token': '$token'});
    // log('Raw Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        final jsonResponse = json.decode(response.body);
        return ProfileResponseModel.fromJson(jsonResponse);
      } catch (e) {
        throw Exception('Failed to parse response as JSON: $e');
      }
    } else {
      throw Exception('Failed to load profile data');
    }
  }
}
