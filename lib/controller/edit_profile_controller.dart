import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/api_endpoints.dart';
import '../model/profile_response_model.dart';
import '../views/home/home_page.dart';
import 'user_profile_controller.dart';

class EditProfileController {
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
  final TextEditingController designationController = TextEditingController();

  String? selectedUserType;
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
  String? networkImageUrl;
  String? userId;

  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);

  final ProfileController profileController = Get.put(ProfileController());

  EditProfileController() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('childId');
      log('[log] Loaded User ID: $userId');
    } catch (e) {
      log('[Error] Failed to load User ID from SharedPreferences: $e');
    }
  }

  Future<void> loadProfileData() async {
    try {
      ProfileResponseModel profile = await profileController.fetchProfileData();

      firstNameController.text = profile.data.firstName ?? '';
      fatherNameController.text = profile.data.fathersName ?? '';
      lastNameController.text = profile.data.lastName ?? '';
      contactController.text = profile.data.contact ?? '';
      emailController.text = profile.data.email ?? '';
      motherNameController.text = profile.data.mothersName ?? '';
      siblingNumberController.text = profile.data.numberOfSiblings ?? '';
      aboutController.text = profile.data.about ?? '';

      heightController.text = profile.data.height ?? '';
      weightController.text = profile.data.weight ?? '';
      weightController.text = profile.data.weight ?? '';
      incomeController.text = profile.data.income ?? '';
      workingAtController.text = profile.data.workingAt ?? '';
      ageController.text = profile.data.age.toString() ?? '';
      designationController.text = profile.data.designation ?? '';

      if (profile.data.dob != null && profile.data.dob!.isNotEmpty) {
        try {
          DateTime? date;

          try {
            date = DateTime.parse(profile.data.dob!);
          } catch (e) {
            try {
              final parts = profile.data.dob!.split('-');
              if (parts.length == 3) {
                date = DateTime(
                  int.parse(parts[2]),
                  int.parse(parts[1]),
                  int.parse(parts[0]),
                );
              }
            } catch (e) {
              log('Error parsing date in DD-MM-YYYY format: $e');
            }
          }

          if (date != null) {
            dateOfBirthController.text =
                "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

            int age = DateTime.now().year - date.year;
            if (DateTime.now().month < date.month ||
                (DateTime.now().month == date.month &&
                    DateTime.now().day < date.day)) {
              age--;
            }
            ageController.text = age.toString();
          } else {
            print('Could not parse date: ${profile.data.dob}');

            dateOfBirthController.text = profile.data.dob ?? '';
            ageController.text = profile.data.age?.toString() ?? '';
          }
        } catch (e) {
          log('Error handling date of birth: $e');

          dateOfBirthController.text = profile.data.dob ?? '';
          ageController.text = profile.data.age?.toString() ?? '';
        }
      }

      selectedUserType = profile.data.userType;
      profileCreatedBY = profile.data.createById;
      selectedFatherProfession = profile.data.fathersProfessionId;
      selectedMotherProfession = profile.data.mothersProfessionId;
      selectedMaritalStatus = profile.data.maritalStatusId;
      selectedBloodGroup = profile.data.bloodGroupId;
      selectedBodyType = profile.data.bodyTypeId;
      selectedSkinComplextion = profile.data.skinComplexionId;
      selectedEducation = profile.data.educationId;
      selectedProfession = profile.data.professionId;
      selectedGotra = profile.data.gotraId;
      selectedManglik = profile.data.manglik;
      selectedRaasi = profile.data.rassiId;
      selectedNativePlace = profile.data.nativePlaceId;
      selectedLivesIn = profile.data.livesInId;
      selectedLocation = profile.data.workLocationId;

      if (profile.data.profileImg != null) {
        networkImageUrl = profile.data.profileImg;
      }
    } catch (e) {
      log('[Error] Failed to load profile data: $e');
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
        log('[Debug] Image picked successfully: ${pickedFile.path}');
      }
    } catch (e) {
      log('[Error] Failed to pick image: $e');
    }
  }

  Future<bool> updateProfileData() async {
    if (userId == null) {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('childId');
      log('[log] Reloaded User ID: $userId');
    }

    if (userId == null) {
      Get.snackbar("UserId", "UserId Not Found",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }

    try {
      final url = Uri.parse("${baseUrl}edit_profile");
      final request = http.MultipartRequest(
        'POST',
        url,
      );

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        request.headers['token'] = '$token';
      }

      Map<String, String> fields = {
        'id': userId!,
        'user_type': selectedUserType ?? "",
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
        'designation': designationController.text,
        'income': incomeController.text,
        'working_at': workingAtController.text,
        'work_location': selectedLocation ?? "",
        'gotra': selectedGotra ?? "",
        'manglik': selectedManglik ?? "",
        'rassi': selectedRaasi ?? "",
        'age': ageController.text,
      };

      request.fields.addAll(fields);

      log('[Debug] Request fields: ${json.encode(fields)}');

      if (profileImage != null && profileImage!.existsSync()) {
        log('[Debug] Adding image to request: ${profileImage!.path}');
        log('[Debug] Image size: ${await profileImage!.length()} bytes');

        var imageFile = await http.MultipartFile.fromPath(
          'profile_img',
          profileImage!.path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(imageFile);
        log('[Debug] Image added to request successfully');
      }

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException('Request timed out');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);
      log('[Response] Status Code: ${response.statusCode}');
      log('[Response] Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 200) {
          Get.snackbar("Success", "Profile updated successfully",
              backgroundColor: Colors.green,
              colorText: const Color(0xffffffff),
              snackPosition: SnackPosition.TOP);
          // _showSuccessSnackBar(context, 'Profile updated successfully');

          _clearFormFields();

          Get.offAll(() => const HomePage());

          return true;
        } else {
          Get.snackbar("Failed", "Profile updated failed",
              backgroundColor: Colors.red,
              colorText: const Color(0xffffffff),
              snackPosition: SnackPosition.TOP);
          return false;
        }
      } else {
        Get.snackbar("Failed", "Server Error",
            backgroundColor: Colors.red,
            colorText: const Color(0xffffffff),
            snackPosition: SnackPosition.TOP);
        return false;
      }
    } catch (e) {
      Get.snackbar("Failed", "Something went wrong",
          backgroundColor: Colors.red,
          colorText: const Color(0xffffffff),
          snackPosition: SnackPosition.TOP);
      log('[Exception] Error updating profile: $e');

      return false;
    }
  }

  void _clearFormFields() {
    firstNameController.clear();
    fatherNameController.clear();
    lastNameController.clear();
    contactController.clear();
    emailController.clear();
    motherNameController.clear();
    siblingNumberController.clear();
    aboutController.clear();
    dateOfBirthController.clear();
    heightController.clear();
    weightController.clear();
    designationController.clear();
    incomeController.clear();
    workingAtController.clear();
    ageController.clear();

    selectedUserType = null;
    profileCreatedBY = null;
    selectedFatherProfession = null;
    selectedMotherProfession = null;
    selectedMaritalStatus = null;
    selectedBloodGroup = null;
    selectedBodyType = null;
    selectedSkinComplextion = null;
    selectedEducation = null;
    selectedProfession = null;
    selectedGotra = null;
    selectedManglik = null;
    selectedRaasi = null;
    selectedNativePlace = null;
    selectedLivesIn = null;
    selectedLocation = null;

    profileImage = null;
    imageNotifier.value = null;

    log('[Debug] All form fields cleared');
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
