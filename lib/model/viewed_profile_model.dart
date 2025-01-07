class ViewedProfileResponse {
  final int status;
  final String message;
  final List<Profile> data;

  ViewedProfileResponse(
      {required this.status, required this.message, required this.data});

  factory ViewedProfileResponse.fromJson(Map<String, dynamic> json) {
    return ViewedProfileResponse(
      status: json['status'],
      message: json['msg'],
      data: List<Profile>.from(json['data'].map((x) => Profile.fromJson(x))),
    );
  }
}

class Profile {
  final String id;
  final String userId;
  final String personId;
  final String status;
  final String parentId;
  final String profileImg;
  final String userType;
  final String firstName;
  final String lastName;
  final String contact;
  final String email;
  final String about;
  final String maritalStatusName;
  final String bloodGroupName;
  final String bodyTypeName;
  final String skinComplexionName;
  final String nativePlaceName;
  final String workLocationName;
  final String educationName;
  final String professionName;
  final String age;
  final String height;
  final String dob;
  final String weight;
  final String bloodGroup;
  final String bodyType;
  final String livesIn;
  final String profileCreatedBy;
  final String designation;
  final String income;
  final String workingAt;
  final String workLocation;
  final String gotra;
  final String manglik;
  final String raasi;
  final String fatherName;
  final String motherName;
  final String fatherProfession;
  final String motherProfession;
  final String siblings;
  final String preferMinAge;
  final String preferMaxAge;
  final String preferMinHeight;
  final String preferMaxHeight;
  final String preferedBodyType;
  final String preferComplexion;
  final String preferMaritalStatus;
  final String preferEducation;
  final String preferProfession;
  final String preferLivesIn;

  Profile({
    required this.id,
    required this.userId,
    required this.personId,
    required this.status,
    required this.parentId,
    required this.profileImg,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.email,
    required this.about,
    required this.maritalStatusName,
    required this.bloodGroupName,
    required this.bodyTypeName,
    required this.skinComplexionName,
    required this.nativePlaceName,
    required this.workLocationName,
    required this.educationName,
    required this.professionName,
    required this.age,
    required this.height,
    required this.dob,
    required this.weight,
    required this.bloodGroup,
    required this.bodyType,
    required this.livesIn,
    required this.profileCreatedBy,
    required this.designation,
    required this.income,
    required this.workingAt,
    required this.workLocation,
    required this.gotra,
    required this.manglik,
    required this.raasi,
    required this.fatherName,
    required this.motherName,
    required this.fatherProfession,
    required this.motherProfession,
    required this.siblings,
    required this.preferMinAge,
    required this.preferMaxAge,
    required this.preferMinHeight,
    required this.preferMaxHeight,
    required this.preferedBodyType,
    required this.preferComplexion,
    required this.preferMaritalStatus,
    required this.preferEducation,
    required this.preferProfession,
    required this.preferLivesIn,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? "",
      personId: json['person_id'] ?? "",
      status: json['status'] ?? "",
      parentId: json['parent_id'] ?? "",
      profileImg: json['profile_img'] ?? "",
      userType: json['user_type'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      contact: json['contact'] ?? "",
      email: json['email'] ?? " ",
      about: json['about'] ?? "",
      maritalStatusName: json['marital_status_name'] ?? "",
      bloodGroupName: json['blood_group_name'] ?? "",
      bodyTypeName: json['body_type_name'] ?? "",
      skinComplexionName: json['skin_complexion_name'] ?? "",
      nativePlaceName: json['native_place_name'] ?? "",
      workLocationName: json['work_location_name'] ?? "",
      educationName: json['education_name'] ?? "",
      professionName: json['profession_name'] ?? "",
      age: json['age']?.toString() ?? "",
      height: json['height'] ?? "",
      dob: json['dob'] ?? "",
      weight: json['weight'] ?? "",
      bloodGroup: json['blood_group_name'] ?? "",
      bodyType: json['body_type_name'] ?? "",
      livesIn: json['lives_in_name'] ?? "",
      profileCreatedBy: json['create_by_name'] ?? "",
      designation: json['designation'] ?? "",
      income: json['income'] ?? "",
      workingAt: json['working_at'] ?? "",
      workLocation: json['work_location_name'] ?? "",
      gotra: json['gotra_name'] ?? "",
      manglik: json['manglik'] ?? "",
      raasi: json['raasi_name'] ?? "",
      fatherName: json['father_name'] ?? "",
      motherName: json['mother_name'] ?? "",
      fatherProfession: json['fathers_profession_name'] ?? "",
      motherProfession: json['mothers_profession_name'] ?? "",
      siblings: json['siblings_no'] ?? "",
      preferMinAge: json['min_age'] ?? "",
      preferMaxAge: json['max_age'] ?? "",
      preferMinHeight: json['min_height'] ?? "",
      preferMaxHeight: json['max_height'] ?? "",
      preferedBodyType: json['preference_body_type_name'] ?? "",
      preferComplexion: json['preference_skin_complexion_name'] ?? "",
      preferMaritalStatus: json['preference_marital_status_name'] ?? "",
      preferEducation: json['preference_education_name'] ?? "",
      preferProfession: json['preference_profession_name'] ?? "",
      preferLivesIn: json['preference_lives_in_name'] ?? "",
    );
  }
}
