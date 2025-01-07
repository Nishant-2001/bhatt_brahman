class LocationModel {
  final String id;
  final String name;

  LocationModel({required this.id, required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['city'], 
    );
  }
}

class LocationResponse {
  final List<LocationModel> locationList;

  LocationResponse({required this.locationList});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['location'] as List; 
    List<LocationModel> locationList =
        list.map((i) => LocationModel.fromJson(i)).toList();

    return LocationResponse(locationList: locationList);
  }
}
