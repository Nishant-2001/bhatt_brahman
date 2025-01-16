import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';
import '../model/profile_response_model.dart';

class ProfileController {
  Future<ProfileResponseModel> fetchProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null || userId.isEmpty) {
        throw Exception('User ID not found in SharedPreferences');
      }

      final url = Uri.parse('${baseUrl}edit_profile?id=$userId');
      // log('[ProfileController] Fetching profile from URL: $url');

       String? token = prefs.getString('token');
    // log('[ProfileController] Token from SharedPreferences: $token');
    
    if (token == null || token.isEmpty) {
      throw Exception('Token is missing or invalid');
    }

    // Set up the headers with the Authorization token
    
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    // log('[ProfileController] Request headers: $headers');


      final response = await http.get(url, headers: headers);
      // log('[ProfileController] Response status code: ${response.statusCode}');
      // log('[ProfileController] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        // Validate that jsonResponse is a Map
        if (jsonResponse is! Map<String, dynamic>) {
          throw Exception(
              'Invalid response format: expected Map<String, dynamic>');
        }

        // Validate data field exists and is not null
        if (!jsonResponse.containsKey('data') || jsonResponse['data'] == null) {
          throw Exception('Response missing data field or data is null');
        }

        // Validate data is a Map
        if (jsonResponse['data'] is! Map<String, dynamic>) {
          throw Exception('Data field is not in correct format');
        }

        return ProfileResponseModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to load profile data. Status: ${response.statusCode}');
      }
    } catch (e) {
      // log('[ProfileController] Error: $e');
      rethrow;
    }
  }
}
