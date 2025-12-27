/// success : true
/// message : "data fatched!"
/// licence_types : [{"id":1,"title":"Security Agent License"},{"id":2,"title":"Crowd Controller License"},{"id":3,"title":"Investigator License"},{"id":4,"title":"Security Officer License"},{"id":5,"title":"Bodyguard License"}]

class LicenceTypesModel {
  LicenceTypesModel({
    bool? success,
    String? message,
    List<LicenceTypes>? licenceTypes,
  }) {
    _success = success;
    _message = message;
    _licenceTypes = licenceTypes;
  }

  LicenceTypesModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['licence_types'] != null) {
      _licenceTypes = [];
      json['licence_types'].forEach((v) {
        _licenceTypes?.add(LicenceTypes.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<LicenceTypes>? _licenceTypes;
  LicenceTypesModel copyWith({
    bool? success,
    String? message,
    List<LicenceTypes>? licenceTypes,
  }) => LicenceTypesModel(
    success: success ?? _success,
    message: message ?? _message,
    licenceTypes: licenceTypes ?? _licenceTypes,
  );
  bool? get success => _success;
  String? get message => _message;
  List<LicenceTypes>? get licenceTypes => _licenceTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_licenceTypes != null) {
      map['licence_types'] = _licenceTypes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// title : "Security Agent License"

class LicenceTypes {
  LicenceTypes({num? id, String? title}) {
    _id = id;
    _title = title;
  }

  LicenceTypes.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }
  num? _id;
  String? _title;
  LicenceTypes copyWith({num? id, String? title}) =>
      LicenceTypes(id: id ?? _id, title: title ?? _title);
  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }
}
