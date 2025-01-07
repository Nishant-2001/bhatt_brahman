class MaritalStatusModel {
  final String id;
  final String name;

  MaritalStatusModel({required this.id, required this.name});

  factory MaritalStatusModel.fromJson(Map<String, dynamic> json) {
    return MaritalStatusModel(
      id: json['id'],
      name: json['name'], 
    );
  }
}

class MaritalStatusResponse {
  final List<MaritalStatusModel> maritalStatusList;

  MaritalStatusResponse({required this.maritalStatusList});

  factory MaritalStatusResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['marital_status'] as List; 
    List<MaritalStatusModel> maritalStatusList =
        list.map((i) => MaritalStatusModel.fromJson(i)).toList();

    return MaritalStatusResponse(maritalStatusList: maritalStatusList);
  }
}
