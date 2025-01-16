class BodyTypeModel {
  final String id;
  final String name;

  BodyTypeModel({required this.id, required this.name});

  factory BodyTypeModel.fromJson(Map<String, dynamic> json) {
    return BodyTypeModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class BodyTypeResponse {
  final List<BodyTypeModel> bodyTypes;

  BodyTypeResponse({required this.bodyTypes});

  factory BodyTypeResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['body_type'] as List;
    List<BodyTypeModel> bodyTypeList =
        list.map((i) => BodyTypeModel.fromJson(i)).toList();

    return BodyTypeResponse(bodyTypes: bodyTypeList);
  }
}
