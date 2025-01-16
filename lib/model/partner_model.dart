import 'dart:developer';

class PartnerModel {
  final String id;
  final String parentId;
  final String? profileImg;
  final String userType;
  final String firstName;
  final String lastName;
  final String contact;
  final String dob;
  final String height;
  final String? bodyType;
  final String? skinComplexion;
  final String? livesIn;
  final String? profession;
  final String? education;
  final String? age;
  final String? income;
  final String? workingAt;
  final String? workLocation;
  final String? gotra;
  final String? manglik;
  final String? raasi;
  final String? motherName;
  final String? fatherName;
  final String? fatherProfession;
  final String? motherProfession;
  final String? siblings;
  final String? weight;
  final String? bloodGroup;
  final String? maritalStatus;
  final String? profileCreatedBy;
  final String? about;
  final String? nativePlace;
  final String? designation;
  final String? preferedBodyType;
  final String? preferComplexion;
  final String? preferMaritalStatus;
  final String? preferEducation;
  final String? preferProfession;
  final String? preferLivesIn;
  final String? preferMinHeight;
  final String? preferMaxHeight;
  final String? preferMinAge;
  final String? preferMaxAge;
  final String? matchPercentage;
  final String? birthTime;
  final String? birthPlace;

  PartnerModel({
    required this.id,
    required this.parentId,
    this.profileImg,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.dob,
    required this.height,
    this.bodyType,
    this.skinComplexion,
    this.livesIn,
    this.profession,
    this.education,
    this.age,
    this.gotra,
    this.income,
    this.manglik,
    this.raasi,
    this.workLocation,
    this.workingAt,
    this.fatherName,
    this.fatherProfession,
    this.motherName,
    this.motherProfession,
    this.siblings,
    this.weight,
    this.bloodGroup,
    this.maritalStatus,
    this.profileCreatedBy,
    this.about,
    this.nativePlace,
    this.designation,
    this.preferedBodyType,
    this.preferComplexion,
    this.preferMaritalStatus,
    this.preferEducation,
    this.preferProfession,
    this.preferLivesIn,
    this.preferMinHeight,
    this.preferMaxHeight,
    this.preferMinAge,
    this.preferMaxAge,
    this.matchPercentage,
    this.birthPlace,
    this.birthTime,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    log('Processing JSON for age: ${json['age']}');

    String? ageValue;
    if (json['age'] != null) {
      ageValue = json['age'].toString();
      log('Parsed age value: $ageValue');
    }

    return PartnerModel(
        id: json['id'] ?? '',
        parentId: json['parent_id'] ?? '',
        profileImg: json['profile_img'],
        userType: json['user_type'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        contact: json['contact'] ?? '',
        dob: json['dob'] ?? '',
        height: json['height'] ?? '',
        bodyType: json['body_type_name'],
        skinComplexion: json['skin_complexion_name'],
        livesIn: json['lives_in_name'],
        nativePlace: json['native_place_name'],
        profession: json['profession_name'],
        education: json['education_name'],
        age: ageValue,
        income: json['income'],
        workingAt: json['working_at'],
        workLocation: json['work_location_name'],
        gotra: json['gotra_name'],
        manglik: json['manglik'],
        raasi: json['rassi_name'],
        siblings: json['siblings_no'],
        fatherName: json['father_name'],
        motherName: json['mother_name'],
        fatherProfession: json['fathers_profession_name'],
        motherProfession: json['mothers_profession_name'],
        weight: json['weight'],
        bloodGroup: json['blood_group_name'],
        maritalStatus: json['marital_status_name'],
        profileCreatedBy: json['create_by_name'],
        about: json['about'],
        designation: json['designation'],
        preferedBodyType: json['preference_body_type_name'],
        preferComplexion: json['preference_skin_complexion_name'],
        preferMaritalStatus: json['preference_marital_status_name'],
        preferEducation: json['preference_education_name'],
        preferProfession: json['preference_profession_name'],
        preferLivesIn: json['preference_lives_in_name'],
        preferMinHeight: json['preference_min_height'],
        preferMaxHeight: json['preference_max_height'],
        preferMinAge: json['preference_min_age'],
        preferMaxAge: json['preference_max_age'],
        matchPercentage: json['match_percentage'],
        birthPlace: json['birth_place'],
        birthTime: json['birth_time']);
  }
}
