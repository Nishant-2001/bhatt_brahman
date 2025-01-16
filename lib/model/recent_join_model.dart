class RecentJoinResponse {
  final int status;
  final String message;
  final List<UserData> data;

  RecentJoinResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RecentJoinResponse.fromJson(Map<String, dynamic> json) {
    return RecentJoinResponse(
      status: json['status'],
      message: json['msg'],
      data: (json['data']['data'] as List)
          .map((item) => UserData.fromJson(item))
          .toList(),
    );
  }
}

class UserData {
  final String id;
  final String? profileImg;
  final String userType;
  final String? firstName;
  final String? fatherName;
  final String? lastName;
  final String? contact;
  final String? email;
  final String? about;
  final String? dob;
  final String? height;
  final String? weight;
  final String? income;
  final String? workingAt;
  final String? nativePlace;
  final String? bloodGroup;
  final String? bodyType;
  final String? skinComplexion;
  final String? maritalStatus;
  final String? livesIn;
  final String? createdBy;
  final String? education;
  final String? profession;
  final String? designation;
  final String? workLocation;
  final String? gotra;
  final String? raasi;
  final String? manglik;
  final String? fathersName;
  final String? mothersName;
  final String? mothersProfession;
  final String? fathersProfession;
  final String? siblings;
  final String? preferMinAge;
  final String? preferMaxAge;
  final String? preferMinHeight;
  final String? preferMaxHeight;
  final String? preferBodyType;
  final String? preferSkinComplexion;
  final String? preferMaritalStatus;
  final String? preferEducation;
  final String? preferProfession;
  final String? preferLocation;
  final String? birthTime;
  final String? birthPlace;
  final String? age;

  UserData({
    required this.id,
    this.profileImg,
    required this.userType,
    this.firstName,
    this.fatherName,
    this.lastName,
    this.contact,
    this.email,
    this.about,
    this.dob,
    this.height,
    this.weight,
    this.income,
    this.workingAt,
    this.nativePlace,
    this.bloodGroup,
    this.bodyType,
    this.skinComplexion,
    this.maritalStatus,
    this.livesIn,
    this.createdBy,
    this.education,
    this.profession,
    this.designation,
    this.workLocation,
    this.gotra,
    this.raasi,
    this.manglik,
    this.fathersName,
    this.fathersProfession,
    this.mothersName,
    this.mothersProfession,
    this.siblings,
    this.preferBodyType,
    this.preferEducation,
    this.preferLocation,
    this.preferMaritalStatus,
    this.preferMaxAge,
    this.preferMaxHeight,
    this.preferMinAge,
    this.preferMinHeight,
    this.preferProfession,
    this.preferSkinComplexion,
    this.birthPlace,
    this.birthTime,
    this.age,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      profileImg: json['profile_img'],
      userType: json['user_type_name'] ?? '',
      firstName: json['first_name'],
      fatherName: json['father_name'],
      lastName: json['last_name'],
      contact: json['contact'],
      email: json['email'],
      about: json['about'],
      dob: json['dob'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      income: json['income'],
      workingAt: json['working_at_name'],
      nativePlace: json['native_place_name'],
      bloodGroup: json['blood_group_name'],
      bodyType: json['body_type_name'],
      skinComplexion: json['skin_complexion_name'],
      maritalStatus: json['marital_status_name'],
      livesIn: json['lives_in_name'],
      createdBy: json['create_by_name'],
      education: json['education_name'],
      profession: json['profession_name'],
      workLocation: json['work_location_name'],
      gotra: json['gotra_name'],
      raasi: json['rassi_name'],
      manglik: json['manglik'],
      fathersName: json["father_name"],
      fathersProfession: json['fathers_profession_name'],
      mothersName: json['mother_name'],
      mothersProfession: json['mothers_profession_name'],
      siblings: json['siblings_no'],
      preferMinAge: json['preference_min_age'],
      preferMaxAge: json['preference_max_age'],
      preferMinHeight: json['preference_min_height'],
      preferMaxHeight: json['preference_max_height'],
      preferBodyType: json['preference_body_type'],
      preferSkinComplexion: json['preference_skin_complexion'],
      preferMaritalStatus: json["preference_marital_status"],
      preferEducation: json['preference_education'],
      preferProfession: json['preference_profession'],
      preferLocation: json['preference_lives_in'],
      birthPlace: json['birth_place'],
      birthTime: json['birth_time']
    );
  }
}
