class ExecutiveCommitteeMember {
  final String id;
  final String listNumber;
  final String name;
  final String description;
  final String? committeeImage;
  final String typeHindi;
  final String typeEnglish;
  final String positionHindi;
  final String positionEnglish;

  ExecutiveCommitteeMember({
    required this.id,
    required this.listNumber,
    this.committeeImage,
    required this.typeHindi,
    required this.typeEnglish,
    required this.positionHindi,
    required this.positionEnglish,
    required this.name,
    required this.description,
  });

  factory ExecutiveCommitteeMember.fromJson(Map<String, dynamic> json) {
    return ExecutiveCommitteeMember(
      id: json['id'],
      listNumber: json['list_number'],
      committeeImage: json['committee_image'],
      typeHindi: json['type_hindi'],
      typeEnglish: json['type_english'],
      positionHindi: json['position_hindi'],
      positionEnglish: json['position_english'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class ExecutiveCommitteeResponse {
  final int status;
  final String msg;
  final List<ExecutiveCommitteeMember> committee;

  ExecutiveCommitteeResponse({
    required this.status,
    required this.msg,
    required this.committee,
  });

  factory ExecutiveCommitteeResponse.fromJson(Map<String, dynamic> json) {
    var committeeList = (json['data']['committee'] as List)
        .map((item) => ExecutiveCommitteeMember.fromJson(item))
        .toList();

    return ExecutiveCommitteeResponse(
      status: json['status'],
      msg: json['msg'],
      committee: committeeList,
    );
  }
}
