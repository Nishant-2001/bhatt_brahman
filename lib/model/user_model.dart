class UserModel {
  String id;
  String userId;
  String firstName;
  String lastName;
  String email;
  String contact;
  String livesIn;
  String dob;
  String education;
  String about;

  UserModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.livesIn,
    required this.dob,
    required this.education,
    required this.about,
  });

  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      livesIn: json['lives_in'] ?? '',
      dob: json['dob'] ?? '',
      education: json['education'] ?? '',
      about: json['about'] ?? '',
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'contact': contact,
      'lives_in': livesIn,
      'dob': dob,
      'education': education,
      'about': about,
    };
  }
}
