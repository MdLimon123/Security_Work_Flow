class SupportMessageResponse {
  bool? success;
  List<SupportMessage>? messages;

  SupportMessageResponse({this.success, this.messages});

  factory SupportMessageResponse.fromJson(Map<String, dynamic> json) {
    return SupportMessageResponse(
      success: json['success'] ?? false,
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((e) => SupportMessage.fromJson(e))
          .toList(),
    );
  }
}

class SupportMessage {
  final int id;
  final String fullName;
  final String email;
  final String message;
  final String createdAt;

  SupportMessage({
    required this.id,
    required this.fullName,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      message: json['message'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'message': message,
      'created_at': createdAt,
    };
  }
}
