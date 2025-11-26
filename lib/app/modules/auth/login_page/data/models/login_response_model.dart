/// success : true
/// verified : true
/// message : "login successfull!"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY0MjE0ODg1LCJpYXQiOjE3NjQxMjg0ODUsImp0aSI6ImE4ODY0NWZlZjhhYTRmOTY4MDg5YzkxZWJmMWE1NmUxIiwidXNlcl9pZCI6IjEifQ.Vb5nwJxKH6QZJhx0DY9R_vtAENQiIr5KI-mptOFNqnY"
/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpJVCL9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDM4NzY4NSwiaWF0IjoxNzY0MTI4NDg1LCJqdGkiOiI4M2JiZmUzZmQxMjc0NGYwOWI3YmQ3MjhhYzBlOGQ1NCIsInVzZXJfaWQiOiIxIn0.rPJWjvt97JOIkDlk85CEVqlPMu7qe5uskKdZRhEW380"
library;

class LoginResponseModel {
  LoginResponseModel({
    bool? success,
    bool? verified,
    String? message,
    String? access,
    String? refresh,
  }) {
    _success = success;
    _verified = verified;
    _message = message;
    _access = access;
    _refresh = refresh;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _verified = json['verified'];
    _message = json['message'];
    _access = json['access'];
    _refresh = json['refresh'];
  }

  bool? _success;
  bool? _verified;
  String? _message;
  String? _access;
  String? _refresh;

  LoginResponseModel copyWith({
    bool? success,
    bool? verified,
    String? message,
    String? access,
    String? refresh,
  }) => LoginResponseModel(
    success: success ?? _success,
    verified: verified ?? _verified,
    message: message ?? _message,
    access: access ?? _access,
    refresh: refresh ?? _refresh,
  );

  bool? get success => _success;

  bool? get verified => _verified;

  String? get message => _message;

  String? get access => _access;

  String? get refresh => _refresh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['verified'] = _verified;
    map['message'] = _message;
    map['access'] = _access;
    map['refresh'] = _refresh;
    return map;
  }
}
