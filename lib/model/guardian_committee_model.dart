class GuardianCommitteeModel {
  final int? status;
  final String? message;
  final List<CommitteeMember>? committee;

  GuardianCommitteeModel({this.status, this.message, this.committee});

  factory GuardianCommitteeModel.fromJson(Map<String, dynamic> json) {
    return GuardianCommitteeModel(
      status: json['status'] as int?,
      message: json['msg'] as String?,
      committee: (json['data']['committee'] as List<dynamic>?)
          ?.map((item) => CommitteeMember.fromJson(item))
          .toList(),
    );
  }
}

class CommitteeMember {
  final String? id;
  final String? listNumber;
  final String? name;
  final String? description;
  final String? committeeImage;
  final String? typeHindi;
  final String? typeEnglish;
  final String? positionHindi;
  final String? positionEnglish;

  CommitteeMember({
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

  factory CommitteeMember.fromJson(Map<String, dynamic> json) {
    return CommitteeMember(
      id: json['id'] as String?,
      listNumber: json['list_number'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      committeeImage: json['committee_image'] as String?,
      typeHindi: json['type_hindi'] as String?,
      typeEnglish: json['type_english'] as String?,
      positionHindi: json['position_hindi'] as String?,
      positionEnglish: json['position_english'] as String?,
    );
  }
}
