class Advertisement {
  final String id;
  final String advertisementImage;
  final String title;
  final String startDate;
  final String endDate;
  final String url;

  Advertisement({
    required this.id,
    required this.advertisementImage,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.url,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      advertisementImage: json['advertisement_image'],
      title: json['title'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      url: json['url'],
    );
  }
}
