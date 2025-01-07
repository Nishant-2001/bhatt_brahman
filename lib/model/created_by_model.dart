class CreatedByModel {
  final String id;
  final String name;

  CreatedByModel({required this.id, required this.name});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) {
    return CreatedByModel(
      id: json['id'],
      name: json['name'], 
    );
  }
}

class CreatedByResponse {
  final List<CreatedByModel> createdByList;

  CreatedByResponse({required this.createdByList});

  factory CreatedByResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['create_by'] as List; 
    List<CreatedByModel> createdByList =
        list.map((i) => CreatedByModel.fromJson(i)).toList();

    return CreatedByResponse(createdByList: createdByList);
  }
}
