class NotificationModel {
  final int status;
  final String message;
  final List<NotificationItem> notifications;

  NotificationModel({
    required this.status,
    required this.message,
    required this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json['status'],
      message: json['msg'],
      notifications: (json['data']['notification'] as List)
          .map((item) => NotificationItem.fromJson(item))
          .toList(),
    );
  }
}

class NotificationItem {
  final String id;
  final String userId;
  final String deviceToken;
  final String title;
  final String body;
  final String response;
  final String viewStatus;
  final String status;
  final String addedOn;
  final String updatedOn;

  NotificationItem({
    required this.id,
    required this.userId,
    required this.deviceToken,
    required this.title,
    required this.body,
    required this.response,
    required this.viewStatus,
    required this.status,
    required this.addedOn,
    required this.updatedOn,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? "",
      userId: json['user_id'] ?? "",
      deviceToken: json['device_token'] ?? "",
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      response: json['response'] ?? "",
      viewStatus: json['view_status'] ?? "",
      status: json['status'] ?? "",
      addedOn: json['added_on'] ?? "",
      updatedOn: json['updated_on'] ?? "",
    );
  }
}
