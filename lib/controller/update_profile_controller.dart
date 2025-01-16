import 'dart:async';
import 'dart:convert';
// import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../constants/api_endpoints.dart';

class UpdateProfileController {
 
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController siblingNumberController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController workingAtController = TextEditingController();
  final TextEditingController ageController = TextEditingController();


  String? profileCreatedBY;
  String? selectedFatherProfession;
  String? selectedMotherProfession;
  String? selectedMaritalStatus;
  String? selectedBloodGroup;
  String? selectedBodyType;
  String? selectedSkinComplextion;
  String? selectedEducation;
  String? selectedProfession;
  String? selectedGotra;
  String? selectedManglik;
  String? selectedRaasi;
  String? selectedNativePlace;
  String? selectedLivesIn;
  String? selectedLocation;

  File? profileImage;
  String? userId;

  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

  UpdateProfileController() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('childId');
      // log('[log] Loaded User ID: $userId');
    } catch (e) {
      // log('[Error] Failed to load User ID from SharedPreferences: $e');
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        imageNotifier.value = profileImage;
        // log('[Debug] Image picked successfully: ${pickedFile.path}');
      }
    } catch (e) {
      // log('[Error] Failed to pick image: $e');
    }
  }

  Future<bool> updateProfileData(BuildContext context) async {
    if (userId == null) {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('user_id');
      // log('[log] Reloaded User ID: $userId');
    }

    if (userId == null) {
      _showErrorSnackBar(context, 'User ID not found');
      return false;
    }

    try {
      final url = Uri.parse("${baseUrl}edit_profile");
      final request = http.MultipartRequest('POST', url);

      Map<String, String> fields = {
        'id': userId!,
        'create_by': profileCreatedBY ?? "",
        'first_name': firstNameController.text,
        'father_name': fatherNameController.text,
        'last_name': lastNameController.text,
        'contact': contactController.text,
        'email': emailController.text,
        'mother_name': motherNameController.text,
        'fathers_profession': selectedFatherProfession ?? "",
        'mothers_profession': selectedMotherProfession ?? "",
        'siblings_no': siblingNumberController.text,
        'about': aboutController.text,
        'marital_status': selectedMaritalStatus ?? '',
        'dob': dateOfBirthController.text,
        'blood_group': selectedBloodGroup ?? "",
        'height': heightController.text,
        'weight': weightController.text,
        'body_type': selectedBodyType ?? "",
        'skin_complexion': selectedSkinComplextion ?? "",
        'native_place': selectedNativePlace ?? "",
        'lives_in': selectedLivesIn ?? "",
        'education': selectedEducation ?? "",
        'profession': selectedProfession ?? "",
        'income': incomeController.text,
        'working_at': workingAtController.text,
        'work_location': selectedLocation ?? "",
        'gotra': selectedGotra ?? "",
        'manglik': selectedManglik ?? "",
        'rassi': selectedRaasi ?? "",
        'age': ageController.text,
      };

      request.fields.addAll(fields);

      // log('[Debug] Request fields: ${json.encode(fields)}');

      if (profileImage != null && profileImage!.existsSync()) {
        // log('[Debug] Adding image to request: ${profileImage!.path}');
        // log('[Debug] Image size: ${await profileImage!.length()} bytes');

        var imageFile = await http.MultipartFile.fromPath(
          'profile_img',
          profileImage!.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(imageFile);
        // log('[Debug] Image added to request successfully');
      }

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);
      // log('[Response] Status Code: ${response.statusCode}');
      // log('[Response] Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 200) {
          _showSuccessSnackBar(context, 'Profile created Successfully');
          return true;
        } else {
          _showErrorSnackBar(context, jsonResponse['msg'] ?? 'Created Failed');
          return false;
        }
      } else {
        _showErrorSnackBar(context, 'Server Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // log('[Exception] Error updating profile: $e');
      _showErrorSnackBar(context, 'An error occurred while updating profile');
      return false;
    }
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void dispose() {
    imageNotifier.dispose();
    firstNameController.dispose();
    fatherNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    motherNameController.dispose();
    siblingNumberController.dispose();
    aboutController.dispose();
    dateOfBirthController.dispose();
    heightController.dispose();
    weightController.dispose();
    incomeController.dispose();
    workingAtController.dispose();
    ageController.dispose();
  }
}
