/// success : true
/// message : "data fatched!"
/// certificate_types : [{"id":1,"title":"ACC"},{"id":2,"title":"CCCC"}]
library;

class ListOfAccreditationsModel {
  ListOfAccreditationsModel({
    bool? success,
    String? message,
    List<CertificateTypes>? certificateTypes,
  }) {
    _success = success;
    _message = message;
    _certificateTypes = certificateTypes;
  }

  ListOfAccreditationsModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['certificate_types'] != null) {
      _certificateTypes = [];
      json['certificate_types'].forEach((v) {
        _certificateTypes?.add(CertificateTypes.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<CertificateTypes>? _certificateTypes;
  ListOfAccreditationsModel copyWith({
    bool? success,
    String? message,
    List<CertificateTypes>? certificateTypes,
  }) => ListOfAccreditationsModel(
    success: success ?? _success,
    message: message ?? _message,
    certificateTypes: certificateTypes ?? _certificateTypes,
  );
  bool? get success => _success;
  String? get message => _message;
  List<CertificateTypes>? get certificateTypes => _certificateTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_certificateTypes != null) {
      map['certificate_types'] = _certificateTypes
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }
}

/// id : 1
/// title : "ACC"

class CertificateTypes {
  CertificateTypes({num? id, String? title}) {
    _id = id;
    _title = title;
  }

  CertificateTypes.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
  CertificateTypes copyWith({num? id, String? title}) =>
      CertificateTypes(id: id ?? _id, title: title ?? _title);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }
}
