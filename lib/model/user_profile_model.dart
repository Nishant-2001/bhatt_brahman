class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String profileImg;
  final String userType;

  UserProfile(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.profileImg,
      required this.userType});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      profileImg: json["profile_img"] ?? '',
      userType: json["user_type"] ?? '',
    );
  }
}
