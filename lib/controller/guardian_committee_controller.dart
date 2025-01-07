import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../model/guardian_committee_model.dart';

class GuardianCommitteeController {
  static const String _apiUrl =
      '${baseUrl}guardiancommittee/';

  
  static Future<GuardianCommitteeModel?> fetchCommitteeData() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return GuardianCommitteeModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // print('Error fetching Guardian Committee data: $error');
      return null;
    }
  }
}
