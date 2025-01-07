import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/api_endpoints.dart';
import '../model/blood_type_model.dart';
import '../model/body_type_model.dart';
import '../model/created_by_model.dart';
import '../model/education_model.dart';
import '../model/gotra_model.dart';
import '../model/location_model.dart';
import '../model/marital_status_model.dart';
import '../model/profession_model.dart';
import '../model/raashi_model.dart';
import '../model/skin_complexion_model.dart';

class DropdownController extends GetxController {

  
  Future<GotraResponse> fetchGotras() async {
    final response = await http.get(Uri.parse('${baseUrl}gotralist/'));

    if (response.statusCode == 200) {
      return GotraResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load gotras');
    }
  }

  Future<BodyTypeResponse> fetchBodyType() async {
    final response = await http.get(Uri.parse('${baseUrl}body_typelist/'));
    if (response.statusCode == 200) {
      return BodyTypeResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load bodyTypes');
    }
  }

  Future<BloodTypeResponse> fetchBloodType() async {
    final response = await http.get(Uri.parse('${baseUrl}blood_group/'));
    if (response.statusCode == 200) {
      return BloodTypeResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load bodyTypes');
    }
  }
  

  Future<SkinComplexionResponse> fetchSkinComplexion() async {
    final response = await http.get(Uri.parse('${baseUrl}skin_complexionlist/'));
    if (response.statusCode == 200) {
      return SkinComplexionResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load skinComplexion');
    }
  }

  Future<MaritalStatusResponse> fetchMaritalStatus() async {
    final response = await http.get(Uri.parse('${baseUrl}marital_status/'));

    if (response.statusCode == 200) {
      return MaritalStatusResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load maritalStatus');
    }

  }

  Future<LocationResponse> fetchLocation() async {
    final response = await http.get(Uri.parse('${baseUrl}locationlist/'));

    if (response.statusCode == 200) {
      return LocationResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load maritalStatus');
    }

  }

  Future<CreatedByResponse>  fetchCreatedBy() async {
    final response = await http.get(Uri.parse('${baseUrl}createbylist/'));

    if (response.statusCode == 200) {
      return CreatedByResponse.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load createdBy');
    }

  }

  Future<RaashiResponse> fetchRaashis() async {
    final response = await http.get(Uri.parse('${baseUrl}raashilist/'));

    if (response.statusCode == 200) {
      return RaashiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load raashis');
    }
  }

  Future<EducationResponse> fetchEducation() async {
    final response = await http.get(Uri.parse('${baseUrl}educationlist/'));

    if (response.statusCode == 200) {
      return EducationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load education list');
    }
  }

  Future<ProfessionResponse> fetchProfession() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}professionlist/'));

      if (response.statusCode == 200) {
        return ProfessionResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load profession list');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
