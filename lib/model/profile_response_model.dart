import 'profile_data_model.dart';

class ProfileResponseModel {
  final int status;
  final String msg;
  final ProfileData data;

  ProfileResponseModel({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    
    if (!json.containsKey('data') || json['data'] == null) {
      throw Exception('Response data is missing or null');
    }

   
    if (json['data'] is! Map<String, dynamic>) {
      throw Exception('Response data is not in the correct format');
    }

    return ProfileResponseModel(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}