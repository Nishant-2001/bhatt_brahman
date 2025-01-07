class GotraModel {
  final String id;
  final String gotraName;

  GotraModel({required this.id, required this.gotraName});

  factory GotraModel.fromJson(Map<String, dynamic> json) {
    return GotraModel(
      id: json['id'],
      gotraName: json['gotra_name'],
    );
  }
}

class GotraResponse {
  final List<GotraModel> gotras;

  GotraResponse({required this.gotras});

  factory GotraResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['gotras'] as List;
    List<GotraModel> gotraList = list.map((i) => GotraModel.fromJson(i)).toList();

    return GotraResponse(gotras: gotraList);
  }
}