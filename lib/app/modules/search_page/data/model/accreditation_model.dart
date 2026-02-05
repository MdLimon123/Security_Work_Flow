class AccreditationResponseModel {
  final bool? success;
  final String? message;
  final List<CertificateType>? certificateTypes;

  AccreditationResponseModel({
    this.success,
    this.message,
    this.certificateTypes,
  });

  factory AccreditationResponseModel.fromJson(Map<String, dynamic> json) {
    return AccreditationResponseModel(
      success: json['success'],
      message: json['message'],
      certificateTypes: (json['certificate_types'] as List<dynamic>?)
          ?.map((e) => CertificateType.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'certificate_types':
          certificateTypes?.map((e) => e.toJson()).toList(),
    };
  }
}

class CertificateType {
  final int? id;
  final String? title;

  CertificateType({
    this.id,
    this.title,
  });

  factory CertificateType.fromJson(Map<String, dynamic> json) {
    return CertificateType(
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

