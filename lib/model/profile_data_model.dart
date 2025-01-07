import '../constants/assets.dart';

class ProfileData {
  final String id;
  final String userId;
  final String? profileImg;
  final String? userType;
  final String? createBy;
  final String firstName;
  final String? fathersName;
  final String? lastName;
  final String? contact;
  final String? email;
  final String? about;
  final String? maritalStatus;
  final String? dob;
  final int? age;
  final String? bloodGroup;
  final String? height;
  final String? weight;
  final String? bodyType;
  final String? skinComplextion;
  final String? nativePlace;
  final String? livesIn;
  final String? education;
  final String? profession;
  final String? income;
  final String? workingAt;
  final String? workLocation;
  final String? gotra;
  final String? manglik;
  final String? rassi;
  final String? verificationStatus;
  final String? password;
  final String? status;
  final String? addedOn;
  final String? updatedOn;
  final String? mothersName;
  final String? fathersProfession;
  final String? mothersProfession;
  final String? numberOfSiblings;
  final String? designation;
  String? createById;
  String? maritalStatusId;
  String? bloodGroupId;
  String? bodyTypeId;
  String? skinComplexionId;
  String? educationId;
  String? professionId;
  String? fathersProfessionId;
  String? mothersProfessionId;
  String? gotraId;
  String? manglikId;
  String? rassiId;
  String? nativePlaceId;
  String? livesInId;
  String? workLocationId;
  final List<String> additionalImages;


  ProfileData({
    required this.id,
    required this.userId,
    this.profileImg,
    this.userType,
    this.createBy,
    required this.firstName,
    this.fathersName,
    this.lastName,
    this.contact,
    this.email,
    this.about,
    this.maritalStatus,
    this.dob,
    this.age,
    this.bloodGroup,
    this.height,
    this.weight,
    this.bodyType,
    this.skinComplextion,
    this.nativePlace,
    this.livesIn,
    this.education,
    this.profession,
    this.income,
    this.workingAt,
    this.workLocation,
    this.gotra,
    this.manglik,
    this.rassi,
    this.verificationStatus,
    this.password,
    this.status,
    this.addedOn,
    this.updatedOn,
    this.mothersName,
    this.fathersProfession,
    this.mothersProfession,
    this.numberOfSiblings,
    this.designation,
    this.bloodGroupId,
    this.bodyTypeId,
    this.createById,
    this.educationId,
    this.fathersProfessionId,
    this.gotraId,
    this.livesInId,
    this.maritalStatusId,
    this.mothersProfessionId,
    this.nativePlaceId,
    this.professionId,
    this.rassiId,
    this.skinComplexionId,
    this.workLocationId,
    required this.additionalImages,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      profileImg: json['profile_img'] ?? placeholderImage,
      bloodGroupId: json['blood_group'],
      bodyTypeId: json['body_type'],
      createById: json['create_by'],
      educationId: json['education'],
      fathersProfessionId: json['fathers_profession'],
      gotraId: json['gotra'],
      livesInId: json['lives_in'],
      maritalStatusId: json['marital_status'],
      professionId: json['profession'],
      rassiId: json['rassi'],
      skinComplexionId: json['skin_complexion'],
      workLocationId: json['work_location'],
      mothersProfessionId: json['mothers_profession'],
      nativePlaceId: json['native_place'],
      userType: json['user_type'],
      createBy: json['create_by_name'],
      firstName: json['first_name'] ?? '',
      fathersName: json['father_name'],
      lastName: json['last_name'],
      contact: json['contact'],
      email: json['email'],
      about: json['about'] ?? '',
      maritalStatus: json['marital_status_name'],
      dob: json['dob'],
      age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
      bloodGroup: json['blood_group_name'],
      height: json['height'],
      weight: json['weight'],
      bodyType: json['body_type_name'],
      skinComplextion: json['skin_complexion_name'],
      nativePlace: json['native_place_name'],
      livesIn: json['lives_in_name'],
      education: json['education_name'],
      profession: json['profession_name'],
      income: json['income'],
      workingAt: json['working_at'],
      workLocation: json['work_location_name'],
      gotra: json['gotra_name'],
      manglik: json['manglik'],
      rassi: json['rassi_name'],
      verificationStatus: json['verification_status'],
      password: json['password'],
      status: json['status'],
      addedOn: json['added_on'],
      updatedOn: json['updated_on'],
      mothersName: json['mother_name'],
      fathersProfession: json['fathers_profession_name'],
      mothersProfession: json['mothers_profession_name'],
      numberOfSiblings: json['siblings_no'],
      designation: json['designation'],
      additionalImages: (json['additional_images'] is List)
          ? List<String>.from(json['additional_images'])
          : [],
    );
  }
}
