import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../model/founder_committee_model.dart';

class FounderCommitteeController {
  static const String _url = '${baseUrl}foundercommittee/';

  static Future<FounderCommitteeModel?> fetchCommitteeData() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        return FounderCommitteeModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // print('Error: $e');
      return null;
    }
  }
}