class ReferralModel {
  final bool? success;
  final String? message;
  final String? code;

  ReferralModel({
     this.success,
     this.message,
     this.code,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      code: json['code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'code': code,
    };
  }
}
