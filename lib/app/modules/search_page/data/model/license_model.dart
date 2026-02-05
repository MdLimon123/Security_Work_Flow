class LicenseResponseModel {
  final bool? success;
  final String? message;
  final List<LicenseType>? licenceTypes;

  LicenseResponseModel({
    this.success,
    this.message,
    this.licenceTypes,
  });

  factory LicenseResponseModel.fromJson(Map<String, dynamic> json) {
    return LicenseResponseModel(
      success: json['success'],
      message: json['message'],
      licenceTypes: (json['licence_types'] as List<dynamic>?)
          ?.map((e) => LicenseType.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'licence_types': licenceTypes?.map((e) => e.toJson()).toList(),
    };
  }
}
class LicenseType {
  final int? id;
  final String? title;

  LicenseType({
    this.id,
    this.title,
  });

  factory LicenseType.fromJson(Map<String, dynamic> json) {
    return LicenseType(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
