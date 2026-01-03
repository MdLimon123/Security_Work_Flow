/// success : true
/// message : "code fatched !"
/// users : [{"id":18,"email":"mahid@gmail.com","first_name":"Nahid Rahman","phone":null,"is_email_varified":false,"user_type":"guard","is_subscribe":false,"is_earned":false,"gender":"","language":null,"address":"","create_at":"2025-12-29T06:59:30.411628Z"}]
library;

class MyReferListModel {
  MyReferListModel({bool? success, String? message, List<Users>? users}) {
    _success = success;
    _message = message;
    _users = users;
  }

  MyReferListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Users>? _users;
  MyReferListModel copyWith({
    bool? success,
    String? message,
    List<Users>? users,
  }) => MyReferListModel(
    success: success ?? _success,
    message: message ?? _message,
    users: users ?? _users,
  );
  bool? get success => _success;
  String? get message => _message;
  List<Users>? get users => _users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 18
/// email : "mahid@gmail.com"
/// first_name : "Nahid Rahman"
/// phone : null
/// is_email_varified : false
/// user_type : "guard"
/// is_subscribe : false
/// is_earned : false
/// gender : ""
/// language : null
/// address : ""
/// create_at : "2025-12-29T06:59:30.411628Z"

class Users {
  Users({
    num? id,
    String? email,
    String? firstName,
    dynamic phone,
    bool? isEmailVarified,
    String? userType,
    bool? isSubscribe,
    bool? isEarned,
    String? gender,
    dynamic language,
    String? address,
    String? createAt,
  }) {
    _id = id;
    _email = email;
    _firstName = firstName;
    _phone = phone;
    _isEmailVarified = isEmailVarified;
    _userType = userType;
    _isSubscribe = isSubscribe;
    _isEarned = isEarned;
    _gender = gender;
    _language = language;
    _address = address;
    _createAt = createAt;
  }

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _phone = json['phone'];
    _isEmailVarified = json['is_email_varified'];
    _userType = json['user_type'];
    _isSubscribe = json['is_subscribe'];
    _isEarned = json['is_earned'];
    _gender = json['gender'];
    _language = json['language'];
    _address = json['address'];
    _createAt = json['create_at'];
  }
  num? _id;
  String? _email;
  String? _firstName;
  dynamic _phone;
  bool? _isEmailVarified;
  String? _userType;
  bool? _isSubscribe;
  bool? _isEarned;
  String? _gender;
  dynamic _language;
  String? _address;
  String? _createAt;
  Users copyWith({
    num? id,
    String? email,
    String? firstName,
    dynamic phone,
    bool? isEmailVarified,
    String? userType,
    bool? isSubscribe,
    bool? isEarned,
    String? gender,
    dynamic language,
    String? address,
    String? createAt,
  }) => Users(
    id: id ?? _id,
    email: email ?? _email,
    firstName: firstName ?? _firstName,
    phone: phone ?? _phone,
    isEmailVarified: isEmailVarified ?? _isEmailVarified,
    userType: userType ?? _userType,
    isSubscribe: isSubscribe ?? _isSubscribe,
    isEarned: isEarned ?? _isEarned,
    gender: gender ?? _gender,
    language: language ?? _language,
    address: address ?? _address,
    createAt: createAt ?? _createAt,
  );
  num? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  dynamic get phone => _phone;
  bool? get isEmailVarified => _isEmailVarified;
  String? get userType => _userType;
  bool? get isSubscribe => _isSubscribe;
  bool? get isEarned => _isEarned;
  String? get gender => _gender;
  dynamic get language => _language;
  String? get address => _address;
  String? get createAt => _createAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['phone'] = _phone;
    map['is_email_varified'] = _isEmailVarified;
    map['user_type'] = _userType;
    map['is_subscribe'] = _isSubscribe;
    map['is_earned'] = _isEarned;
    map['gender'] = _gender;
    map['language'] = _language;
    map['address'] = _address;
    map['create_at'] = _createAt;
    return map;
  }
}
