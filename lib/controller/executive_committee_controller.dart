import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/executive_committee_model.dart';

class ExecutiveCommitteeController {
  Future<ExecutiveCommitteeResponse?> fetchExecutiveCommittee() async {
    const url = "${baseUrl}executivecommittee/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ExecutiveCommitteeResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // print('Error fetching executive committee: $e');
      return null;
    }
  }
}
