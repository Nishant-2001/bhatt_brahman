import 'dart:convert';
// import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/prefferences_model.dart';
import '../constants/api_endpoints.dart';

class PrefferencesController { 
  Future<PrefferencesModel?> fetchUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userId = prefs.getString('childId') ?? prefs.getString('child_id');

      // log('[Debug] Retrieved userId from SharedPreferences: $userId');

      if (userId == null) {
        throw Exception('User ID not found in SharedPreferences');
      }

      // log('[Debug] All SharedPreferences keys: ${prefs.getKeys()}');

      final token = prefs.getString("token");

      var url = Uri.parse("${baseUrl}preferences?user_id=$userId");
      // log('[Debug] API URL: $url');

      final response = await http.get(url, headers: {'token': '$token'});
      // log('[Debug] Response Status Code: ${response.statusCode}');
      // log('[Debug] Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // log('[Debug] Decoded JSON: $jsonResponse');

        if (jsonResponse['status'] == 200) {
          // log('[Debug] User Preferences Data: ${jsonResponse['data']}');
          return PrefferencesModel.fromJson(jsonResponse['data']);
        } else {
          // log('[Debug] API Error: ${jsonResponse['msg']}');

          if (jsonResponse['status'] == 404) {
            // log('[Debug] No preferences found for user $userId');
          }
        }
      } else {
        // log('[Debug] Failed to fetch preferences with status code ${response.statusCode}');
      }
    } catch (e) {
      // log('[Debug] Error fetching user preferences: $e');
    }
    return null;
  }

  Future<void> checkSavedUserId() async {
    // final prefs = await SharedPreferences.getInstance();

    // final normalUserId = prefs.getString('userId');
    // final childId = prefs.getString('child_id');
    // final allKeys = prefs.getKeys();

    // log('[Debug] userId: $normalUserId');
    // log('[Debug] child_id: $childId');
    // log('[Debug] All SharedPreferences keys: $allKeys');
  }
}
