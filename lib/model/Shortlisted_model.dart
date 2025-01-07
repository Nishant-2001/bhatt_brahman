class ShortlistedModel {
  final String id;
  final String userId;
  final String interestedPersonId;
  final String parentId;
  final String profileImg;
  final String userType;
  final String createdBy;
  final String firstName;
  final String fatherName;
  final String lastName;
  final String contact;
  final String email;
  final String motherName;
  final String fatherProfession;
  final String motherProfession;
  final String siblings;
  final String about;
  final String maritalStatus;
  final String dob;
  final String bloodGroup;
  final String height;
  final String weight;
  final String bodyType;
  final String skinComplexion;
  final String nativePlace;
  final String livesIn;
  final String education;
  final String profession;
  final String designation;
  final String income;
  final String workingAt;
  final String workLocation;
  final String gotra;
  final String manglik;
  final String rassi;
  final String preferBodytype;
  final String preferMinAge;
  final String preferMaxAge;
  final String preferMinHeight;
  final String preferMaxHeight;
  final String age;
  final String preferSkinComplexion;
  final String preferMaritalStatus;
  final String preferEducation;
  final String preferProfession;
  final String preferLivesIn;
  final String matchPercentage;
  final String parentContact;
  final String preferBodyType;

  ShortlistedModel({
    required this.id,
    required this.userId,
    required this.interestedPersonId,
    required this.parentId,
    required this.profileImg,
    required this.userType,
    required this.createdBy,
    required this.firstName,
    required this.fatherName,
    required this.lastName,
    required this.contact,
    required this.email,
    required this.motherName,
    required this.fatherProfession,
    required this.motherProfession,
    required this.siblings,
    required this.about,
    required this.maritalStatus,
    required this.dob,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.bodyType,
    required this.skinComplexion,
    required this.nativePlace,
    required this.livesIn,
    required this.education,
    required this.profession,
    required this.designation,
    required this.income,
    required this.workingAt,
    required this.workLocation,
    required this.gotra,
    required this.manglik,
    required this.rassi,
    required this.preferBodytype,
    required this.preferMaxAge,
    required this.preferMaxHeight,
    required this.preferMinAge,
    required this.preferMinHeight,
    required this.age,
    required this.preferSkinComplexion,
    required this.preferMaritalStatus,
    required this.preferEducation,
    required this.preferProfession,
    required this.preferLivesIn,
    required this.matchPercentage,
    required this.parentContact,
    required this.preferBodyType,
  });

  factory ShortlistedModel.fromJson(Map<String, dynamic> json) {
    return ShortlistedModel(
      id: json['id'],
      userId: json['user_id'],
      interestedPersonId: json['interest_person_id'],
      parentId: json['parent_id'],
      profileImg: json['profile_img'] ?? "",
      userType: json['user_type'] ?? "",
      createdBy: json['create_by_name'] ?? " ",
      firstName: json['first_name'] ?? "",
      fatherName: json['father_name'] ?? "",
      lastName: json['last_name'] ?? "",
      contact: json['contact'] ?? "",
      email: json['email'] ?? "",
      motherName: json['mother_name'] ?? "",
      fatherProfession: json['fathers_profession_name'] ?? "",
      motherProfession: json['mothers_profession_name'] ?? "",
      siblings: json['siblings_no'] ?? "",
      about: json['about'] ?? "",
      maritalStatus: json['marital_status_name'] ?? "",
      dob: json['dob'] ?? "",
      bloodGroup: json['blood_group_name'] ?? "",
      height: json['height'] ?? "",
      weight: json['weight'] ?? "",
      bodyType: json['body_type_name'] ?? "",
      skinComplexion: json['skin_complexion_name'] ?? "",
      nativePlace: json['native_place_name'] ?? "",
      livesIn: json['lives_in_name'] ?? "",
      education: json['education_name'] ?? "",
      profession: json['profession_name'] ?? "",
      designation: json['designation'] ?? "",
      income: json['income'] ?? "",
      workingAt: json['working_at'] ?? "",
      workLocation: json['work_location_name'] ?? "",
      gotra: json['gotra_name'] ?? "",
      manglik: json['manglik'] ?? "",
      rassi: json['rassi_name'] ?? "",
      preferBodytype: json['preference_body_type_name'] ?? "",
      preferMinAge: json['min_age'] ?? "",
      preferMaxAge: json['max_age'] ?? "",
      preferMaxHeight: json['max_height'] ?? "",
      preferMinHeight: json['min_height'] ?? "",
      age: json['age'] ?? "",
      preferSkinComplexion: json['preference_skin_complexion_name'] ?? "",
      preferMaritalStatus: json['preference_marital_status_name'] ?? "",
      preferEducation: json['preference_education_name'] ?? "",
      preferProfession: json['preference_profession_name'] ?? "",
      preferLivesIn: json['preference_lives_in_name'] ?? "",
      matchPercentage: json['match_percentage'] ?? " ",
      parentContact: json['parent_contact'] ?? " ",
      preferBodyType: json['preference_body_type_name'] ?? "",
    );
  }
}
