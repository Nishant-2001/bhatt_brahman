class BloodTypeModel {
  final String id;
  final String name;

  BloodTypeModel({required this.id, required this.name});

  factory BloodTypeModel.fromJson(Map<String, dynamic> json) {
    return BloodTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class BloodTypeResponse {
  final List<BloodTypeModel> bloodTypeList;

  BloodTypeResponse({required this.bloodTypeList});

  factory BloodTypeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['blood_group'] as List;
    List<BloodTypeModel> bloodTypeList =
        list.map((i) => BloodTypeModel.fromJson(i)).toList();

    return BloodTypeResponse(bloodTypeList: bloodTypeList);
  }
}
