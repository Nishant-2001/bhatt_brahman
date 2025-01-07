import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_endpoints.dart';
import '../model/recent_join_model.dart';

class RecentJoinController {
  Future<RecentJoinResponse?> fetchRecentJoins() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('childId');

      if (userId == null) {
        throw Exception('User ID not found');
      }

      final url = Uri.parse('${baseUrl}recentjoin?user_id=$userId');

      final token = prefs.getString('token');

      final response = await http.get(url, headers: {'token': '$token'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return RecentJoinResponse.fromJson(data);
      } else {
        throw Exception('Failed to load recent joins');
      }
    } on http.ClientException {
      log('Network Error: Unable to connect to the server');
      return null;
    } catch (e) {
      log('An unexpected error occurred: $e'); 
      return null;
    }
  }
}
