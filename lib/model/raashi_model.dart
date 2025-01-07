class RaashiModel {
  final String id;
  final String raashiName;

  RaashiModel({required this.id, required this.raashiName});

  factory RaashiModel.fromJson(Map<String, dynamic> json) {
    return RaashiModel(
      id: json['id'],
      raashiName: json['raasi_name'],
    );
  }
}

class RaashiResponse {
  final List<RaashiModel> raashis;

  RaashiResponse({required this.raashis});

  factory RaashiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['raashi'] as List;
    List<RaashiModel> raashiList =
        list.map((i) => RaashiModel.fromJson(i)).toList();

    return RaashiResponse(raashis: raashiList);
  }
}
