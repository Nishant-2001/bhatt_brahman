class EducationModel {  
  final String id;
  final String name;

  EducationModel({required this.id, required this.name});

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      id: json['id'],
      name: json['name'], 
    );
  }
}

class EducationResponse {
  final List<EducationModel> educationList;

  EducationResponse({required this.educationList});

  factory EducationResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['education'] as List; 
    List<EducationModel> educationList =
        list.map((i) => EducationModel.fromJson(i)).toList();

    return EducationResponse(educationList: educationList);
  }
}
