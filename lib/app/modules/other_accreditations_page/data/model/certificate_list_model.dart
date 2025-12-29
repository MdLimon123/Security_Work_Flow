/// success : true
/// message : "data fatched!"
/// data : [{"id":17,"accreditation_type":{"id":3,"title":"MMM","discription":"1000","is_active":true,"created_at":"2025-12-02T05:16:20.203210Z","updated_at":"2025-12-02T05:16:20.203261Z"},"accreditation":"/media/accreditations/dating_C2bOU0N.pdf","expire_date":null}]
library;

class CertificateListModel {
  CertificateListModel({bool? success, String? message, List<Data>? data}) {
    _success = success;
    _message = message;
    _data = data;
  }

  CertificateListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;
  CertificateListModel copyWith({
    bool? success,
    String? message,
    List<Data>? data,
  }) => CertificateListModel(
    success: success ?? _success,
    message: message ?? _message,
    data: data ?? _data,
  );
  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 17
/// accreditation_type : {"id":3,"title":"MMM","discription":"1000","is_active":true,"created_at":"2025-12-02T05:16:20.203210Z","updated_at":"2025-12-02T05:16:20.203261Z"}
/// accreditation : "/media/accreditations/dating_C2bOU0N.pdf"
/// expire_date : null

class Data {
  Data({
    num? id,
    AccreditationType? accreditationType,
    String? accreditation,
    dynamic expireDate,
  }) {
    _id = id;
    _accreditationType = accreditationType;
    _accreditation = accreditation;
    _expireDate = expireDate;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _accreditationType = json['accreditation_type'] != null
        ? AccreditationType.fromJson(json['accreditation_type'])
        : null;
    _accreditation = json['accreditation'];
    _expireDate = json['expire_date'];
  }
  num? _id;
  AccreditationType? _accreditationType;
  String? _accreditation;
  dynamic _expireDate;
  Data copyWith({
    num? id,
    AccreditationType? accreditationType,
    String? accreditation,
    dynamic expireDate,
  }) => Data(
    id: id ?? _id,
    accreditationType: accreditationType ?? _accreditationType,
    accreditation: accreditation ?? _accreditation,
    expireDate: expireDate ?? _expireDate,
  );
  num? get id => _id;
  AccreditationType? get accreditationType => _accreditationType;
  String? get accreditation => _accreditation;
  dynamic get expireDate => _expireDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_accreditationType != null) {
      map['accreditation_type'] = _accreditationType?.toJson();
    }
    map['accreditation'] = _accreditation;
    map['expire_date'] = _expireDate;
    return map;
  }
}

/// id : 3
/// title : "MMM"
/// discription : "1000"
/// is_active : true
/// created_at : "2025-12-02T05:16:20.203210Z"
/// updated_at : "2025-12-02T05:16:20.203261Z"

class AccreditationType {
  AccreditationType({
    num? id,
    String? title,
    String? discription,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _title = title;
    _discription = discription;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AccreditationType.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _discription = json['discription'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _title;
  String? _discription;
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;
  AccreditationType copyWith({
    num? id,
    String? title,
    String? discription,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) => AccreditationType(
    id: id ?? _id,
    title: title ?? _title,
    discription: discription ?? _discription,
    isActive: isActive ?? _isActive,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
  );
  num? get id => _id;
  String? get title => _title;
  String? get discription => _discription;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['discription'] = _discription;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
