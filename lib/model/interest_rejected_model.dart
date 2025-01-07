class InterestRejectedModel {
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

  InterestRejectedModel({
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
  });

  factory InterestRejectedModel.fromJson(Map<String, dynamic> json) {
    return InterestRejectedModel(
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
    );
  }
}


