class PrefferencesModel {
  final String userId;
  final String minHeight;
  final String maxHeight;
  final String minAge;
  final String maxAge;
  final String bodyType;
  final String maritalStatus;
  final String skinComplexion;
  final String education;
  final String profession;
  final String livesIn;
  final String bodyTypeId;
  final String maritalStatusId;
  final String skinComplexionId;
  final String educationId;
  final String professionId;
  final String livesInId;
 

  PrefferencesModel({
    required this.userId,
    required this.minHeight,
    required this.maxHeight,
    required this.minAge,
    required this.maxAge,
    required this.bodyType,
    required this.maritalStatus,
    required this.skinComplexion,
    required this.education,
    required this.profession,
    required this.livesIn,
    required this.bodyTypeId,
    required this.educationId,
    required this.livesInId,
    required this.maritalStatusId,
    required this.professionId,
    required this.skinComplexionId,
  });

  factory PrefferencesModel.fromJson(Map<String, dynamic> json) {
    return PrefferencesModel(
      userId: json['user_id'] ?? '',
      minHeight: json['min_height'] ?? '',
      maxHeight: json['max_height'] ?? '',
      minAge: json['min_age'] ?? '',
      maxAge: json['max_age'] ?? '',
      bodyType: json['body_type_name'] ?? '',
      maritalStatus: json['marital_status_name'] ?? '',
      skinComplexion: json['skin_complexion_name'] ?? '',
      education: json['education_name'] ?? '',
      profession: json['profession_name'] ?? '',
      livesIn: json['lives_in_name'] ?? '',
      bodyTypeId: json['body_type'] ?? '',
      maritalStatusId: json['marital_status'] ?? '',
      skinComplexionId: json['skin_complexion'] ?? '',
      educationId: json['education'] ?? '',
      professionId: json['profession'] ?? '',
      livesInId: json['lives_in'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'min_height': minHeight,
      'max_height': maxHeight,
      'min_age': minAge,
      'max_age': maxAge,
      'body_type': bodyType,
      'marital_status': maritalStatus,
      'skin_complexion': skinComplexion,
      'education': education,
      'profession': profession,
      'lives_in': livesIn,
    };
  }
}
