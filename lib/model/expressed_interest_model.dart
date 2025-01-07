class ExpressedInterestModel {
  final String? id;
  final String? userId;
  final String? interestPersonId;
  final String? requestStatus;
  final String? firstName;
  final String? lastName;
  final String? profileImg;
  final String? age;
  final String? height;
  final String? professionName;
  final String? livesInName;
  final String? userType;
  final String? createdBy;
  final String? contact;
  final String? email;
  final String? mothersName;
  final String? fathersProfession;
  final String? mothersProfession;
  final String? siblings;
  final String? about;
  final String? dod;
  final String? weight;
  final String? designation;
  final String? income;
  final String? workingAt;
  final String? manglik;
  final String? minHeight;
  final String? maxHeight;
  final String? minAge;
  final String? maxAge;
  final String? preferSkinComplexion;
  final String? preferMaritalStatus;
  final String? preferEducation;
  final String? preferProfession;
  final String? preferlivesIn;
  final String? parentContact;
  final String? nativePlace;
  final String? workLocation;
  final String? skinComplexion;
  final String? bodyType;
  final String? preferBodyType;
  final String? preferMinHeight;
  final String? preferMaxHeight;
  final String? preferMinAge;
  final String? preferMaxAge;
  final String? bloodGroup;
  final String? maritalStatus;
  final String? livesIn;
  final String? education;
  final String? profession;
  final String? gotra;
  final String? raasi;
  final String? fatherName;
  final String? matchPercentage;

  ExpressedInterestModel({
    this.id,
    this.userId,
    this.interestPersonId,
    this.requestStatus,
    this.firstName,
    this.lastName,
    this.profileImg,
    this.age,
    this.height,
    this.professionName,
    this.livesInName,
    this.about,
    this.bodyType,
    this.contact,
    this.createdBy,
    this.designation,
    this.dod,
    this.email,
    this.fathersProfession,
    this.income,
    this.manglik,
    this.maxAge,
    this.maxHeight,
    this.minAge,
    this.minHeight,
    this.mothersName,
    this.mothersProfession,
    this.nativePlace,
    this.parentContact,
    this.preferBodyType,
    this.preferEducation,
    this.preferMaritalStatus,
    this.preferMaxAge,
    this.preferMaxHeight,
    this.preferMinAge,
    this.preferMinHeight,
    this.preferProfession,
    this.preferSkinComplexion,
    this.preferlivesIn,
    this.siblings,
    this.skinComplexion,
    this.userType,
    this.weight,
    this.workLocation,
    this.workingAt,
    this.bloodGroup,
    this.maritalStatus,
    this.livesIn,
    this.education,
    this.profession,
    this.gotra,
    this.raasi,
    this.fatherName,
    this.matchPercentage,
  });

  factory ExpressedInterestModel.fromJson(Map<String, dynamic> json) {
    return ExpressedInterestModel(
        id: json['id'],
        userId: json['user_id'],
        interestPersonId: json['interest_person_id'],
        requestStatus: json['request_status'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profileImg: json['profile_img'],
        age: json['age'],
        height: json['height'],
        professionName: json['profession_name'],
        livesInName: json['lives_in_name'],
        parentContact: json['parent_contact'],
        contact: json['contact'],
        dod: json['dob'],
        weight: json['weight'],
        bloodGroup: json['blood_group_name'],
        bodyType: json['body_type_name'],
        skinComplexion: json['skin_complexion_name'],
        maritalStatus: json['marital_status_name'],
        nativePlace: json['native_place_name'],
        livesIn: json['lives_in_name'],
        createdBy: json['create_by_name'],
        education: json['education_name'],
        profession: json['profession_name'],
        designation: json['designation'],
        income: json['income'],
        workingAt: json['working_at'],
        workLocation: json['work_location_name'],
        gotra: json['gotra_name'],
        manglik: json['manglik'],
        raasi: json['rassi_name'],
        fatherName: json['father_name'],
        mothersName: json['mother_name'],
        fathersProfession: json['fathers_profession_name'],
        mothersProfession: json['mothers_profession_name'],
        siblings: json['siblings_no'],
        preferMinAge: json['preference_min_age'],
        preferMaxAge: json['preference_max_age'],
        preferMinHeight: json['preference_min_height'],
        preferMaxHeight: json['preference_max_height'],
        preferBodyType: json['preference_body_type_name'],
        preferSkinComplexion: json['preference_skin_complexion_name'],
        preferMaritalStatus: json['preference_marital_status_name'],
        preferEducation: json['preference_education_name'],
        preferProfession: json['preference_profession_name'],
        preferlivesIn: json['preference_lives_in_name'],
        matchPercentage: json['match_percentage']);
  }
}
