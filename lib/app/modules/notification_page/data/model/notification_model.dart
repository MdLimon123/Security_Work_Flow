class NotificationModel {
  bool? success;
  String? message;
  List<NotificationData>? data;

  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  // From JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<NotificationData>.from(
              (json['data'] as List).map((item) => NotificationData.fromJson(item)))
          : [],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data != null
          ? data!.map((item) => item.toJson()).toList()
          : [],
    };
  }
}

class NotificationData {
  int id;
  String title;
  String content;
  String noteType;

  NotificationData({
    required this.id,
    required this.title,
    required this.content,
    required this.noteType,
  });

  // From JSON
  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      noteType: json['note_type'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'note_type': noteType,
    };
  }
}
