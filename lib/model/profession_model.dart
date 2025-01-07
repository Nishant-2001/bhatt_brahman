class ProfessionModel {
  final String id;
  final String name;

  ProfessionModel({required this.id, required this.name});

  factory ProfessionModel.fromJson(Map<String, dynamic> json) {
    return ProfessionModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProfessionResponse {
  final List<ProfessionModel> professionList;

  ProfessionResponse({required this.professionList});

  factory ProfessionResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['profession'] as List;
    List<ProfessionModel> professionList =
        list.map((i) => ProfessionModel.fromJson(i)).toList();

    return ProfessionResponse(professionList: professionList);
  }
}