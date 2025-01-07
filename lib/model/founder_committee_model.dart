class FounderCommitteeModel {
  int? status;
  String? msg;
  List<Committee>? committee;

  FounderCommitteeModel({this.status, this.msg, this.committee});

  FounderCommitteeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null && json['data']['committee'] != null) {
      committee = (json['data']['committee'] as List)
          .map((e) => Committee.fromJson(e))
          .toList();
    }
  }
}

class Committee {
  String? id;
  String? listNumber;
  String? name;
  String? description;
  String? committeeImage;
  String? typeHindi;
  String? typeEnglish;
  String? positionHindi;
  String? positionEnglish;

  Committee({
    this.id,
    this.listNumber,
    this.name,
    this.description,
    this.committeeImage,
    this.typeHindi,
    this.typeEnglish,
    this.positionHindi,
    this.positionEnglish,
  });

  Committee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listNumber = json['list_number'];
    name = json['name'];
    description = json['description'];
    committeeImage = json['committee_image'];
    typeHindi = json['type_hindi'];
    typeEnglish = json['type_english'];
    positionHindi = json['position_hindi'];
    positionEnglish = json['position_english'];
  }
}
