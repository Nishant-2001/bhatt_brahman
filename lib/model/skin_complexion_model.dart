class SkinComplexionModel {
  final String id;
  final String name;

  SkinComplexionModel({required this.id, required this.name});

  factory SkinComplexionModel.fromJson(Map<String, dynamic> json) {
    return SkinComplexionModel(
      id: json['id'],
      name: json['name'], 
    );
  }
}

class SkinComplexionResponse {
  final List<SkinComplexionModel> skinComplexionList;

  SkinComplexionResponse({required this.skinComplexionList});

  factory SkinComplexionResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['skin_complexion'] as List; 
    List<SkinComplexionModel> skinComplexionList =
        list.map((i) => SkinComplexionModel.fromJson(i)).toList();

    return SkinComplexionResponse(skinComplexionList: skinComplexionList);
  }
}
