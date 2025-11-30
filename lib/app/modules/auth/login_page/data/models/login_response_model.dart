/// success : true
/// verified : false
/// message : "login successfull!"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzY0NTc5NDMyLCJpYXQiOjE3NjQ0OTMwMzIsImp0aSI6ImE4YzZjNzczNmEwODQyN2JiZmUzY2M2ZDExNTY4YzI1IiwidXNlcl9pZCI6IjYifQ.eTkeKF7U7PTwUFBRsBP1CGyZNuTJD-6EfO0hM-o-vAc"
/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc2NDc1MjIzMiwiaWF0IjoxNzY0NDkzMDMyLCJqdGkiOiIyNGQ4ZTRjYzY2MzA0M2E1YWYxNzdlOTI5OWI4M2NmNyIsInVzZXJfaWQiOiI2In0.WUrwg6HZfactjYMk4m_WsRykfvt4vRGtxPE95q_i1oU"
/// guard_details : {"id":5,"candidate":{"id":6,"first_name":"sajid hossain","email":"sajidrec@gmail.com","phone":"+880 1771139444","user_type":"guard","image":"/media/profile/Dont_remove_Flutter_Sdk_or_any_sdk_YpD7YwB.png","licences":[],"accreditations":[],"gender":"male","language":"bangla","exprience_in_years":0,"exprience_summary":"","user_redus":10,"bank_name":null,"account_holder_name":null,"account_no":null,"bank_branch":null}}
library;

class LoginResponseModel {
  LoginResponseModel({
    bool? success,
    bool? verified,
    String? message,
    String? access,
    String? refresh,
    GuardDetails? guardDetails,
  }) {
    _success = success;
    _verified = verified;
    _message = message;
    _access = access;
    _refresh = refresh;
    _guardDetails = guardDetails;
  }

  LoginResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _verified = json['verified'];
    _message = json['message'];
    _access = json['access'];
    _refresh = json['refresh'];
    _guardDetails = json['guard_details'] != null
        ? GuardDetails.fromJson(json['guard_details'])
        : null;
  }

  bool? _success;
  bool? _verified;
  String? _message;
  String? _access;
  String? _refresh;
  GuardDetails? _guardDetails;

  LoginResponseModel copyWith({
    bool? success,
    bool? verified,
    String? message,
    String? access,
    String? refresh,
    GuardDetails? guardDetails,
  }) => LoginResponseModel(
    success: success ?? _success,
    verified: verified ?? _verified,
    message: message ?? _message,
    access: access ?? _access,
    refresh: refresh ?? _refresh,
    guardDetails: guardDetails ?? _guardDetails,
  );

  bool? get success => _success;

  bool? get verified => _verified;

  String? get message => _message;

  String? get access => _access;

  String? get refresh => _refresh;

  GuardDetails? get guardDetails => _guardDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['verified'] = _verified;
    map['message'] = _message;
    map['access'] = _access;
    map['refresh'] = _refresh;
    if (_guardDetails != null) {
      map['guard_details'] = _guardDetails?.toJson();
    }
    return map;
  }
}

/// id : 5
/// candidate : {"id":6,"first_name":"sajid hossain","email":"sajidrec@gmail.com","phone":"+880 1771139444","user_type":"guard","image":"/media/profile/Dont_remove_Flutter_Sdk_or_any_sdk_YpD7YwB.png","licences":[],"accreditations":[],"gender":"male","language":"bangla","exprience_in_years":0,"exprience_summary":"","user_redus":10,"bank_name":null,"account_holder_name":null,"account_no":null,"bank_branch":null}

class GuardDetails {
  GuardDetails({num? id, Candidate? candidate}) {
    _id = id;
    _candidate = candidate;
  }

  GuardDetails.fromJson(dynamic json) {
    _id = json['id'];
    _candidate = json['candidate'] != null
        ? Candidate.fromJson(json['candidate'])
        : null;
  }

  num? _id;
  Candidate? _candidate;

  GuardDetails copyWith({num? id, Candidate? candidate}) =>
      GuardDetails(id: id ?? _id, candidate: candidate ?? _candidate);

  num? get id => _id;

  Candidate? get candidate => _candidate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_candidate != null) {
      map['candidate'] = _candidate?.toJson();
    }
    return map;
  }
}

/// id : 6
/// first_name : "sajid hossain"
/// email : "sajidrec@gmail.com"
/// phone : "+880 1771139444"
/// user_type : "guard"
/// image : "/media/profile/Dont_remove_Flutter_Sdk_or_any_sdk_YpD7YwB.png"
/// licences : []
/// accreditations : []
/// gender : "male"
/// language : "bangla"
/// exprience_in_years : 0
/// exprience_summary : ""
/// user_redus : 10
/// bank_name : null
/// account_holder_name : null
/// account_no : null
/// bank_branch : null

class Candidate {
  Candidate({
    num? id,
    String? firstName,
    String? email,
    String? phone,
    String? userType,
    String? image,
    List<dynamic>? licences,
    List<dynamic>? accreditations,
    String? gender,
    String? language,
    num? exprienceInYears,
    String? exprienceSummary,
    num? userRedus,
    dynamic bankName,
    dynamic accountHolderName,
    dynamic accountNo,
    dynamic bankBranch,
  }) {
    _id = id;
    _firstName = firstName;
    _email = email;
    _phone = phone;
    _userType = userType;
    _image = image;
    _licences = licences;
    _accreditations = accreditations;
    _gender = gender;
    _language = language;
    _exprienceInYears = exprienceInYears;
    _exprienceSummary = exprienceSummary;
    _userRedus = userRedus;
    _bankName = bankName;
    _accountHolderName = accountHolderName;
    _accountNo = accountNo;
    _bankBranch = bankBranch;
  }

  Candidate.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _email = json['email'];
    _phone = json['phone'];
    _userType = json['user_type'];
    _image = json['image'];
    if (json['licences'] != null) {
      _licences = [];
      json['licences'].forEach((v) {
        _licences?.add(v);
      });
    }
    if (json['accreditations'] != null) {
      _accreditations = [];
      json['accreditations'].forEach((v) {
        _accreditations?.add(v);
      });
    }
    _gender = json['gender'];
    _language = json['language'];
    _exprienceInYears = json['exprience_in_years'];
    _exprienceSummary = json['exprience_summary'];
    _userRedus = json['user_redus'];
    _bankName = json['bank_name'];
    _accountHolderName = json['account_holder_name'];
    _accountNo = json['account_no'];
    _bankBranch = json['bank_branch'];
  }

  num? _id;
  String? _firstName;
  String? _email;
  String? _phone;
  String? _userType;
  String? _image;
  List<dynamic>? _licences;
  List<dynamic>? _accreditations;
  String? _gender;
  String? _language;
  num? _exprienceInYears;
  String? _exprienceSummary;
  num? _userRedus;
  dynamic _bankName;
  dynamic _accountHolderName;
  dynamic _accountNo;
  dynamic _bankBranch;

  Candidate copyWith({
    num? id,
    String? firstName,
    String? email,
    String? phone,
    String? userType,
    String? image,
    List<dynamic>? licences,
    List<dynamic>? accreditations,
    String? gender,
    String? language,
    num? exprienceInYears,
    String? exprienceSummary,
    num? userRedus,
    dynamic bankName,
    dynamic accountHolderName,
    dynamic accountNo,
    dynamic bankBranch,
  }) => Candidate(
    id: id ?? _id,
    firstName: firstName ?? _firstName,
    email: email ?? _email,
    phone: phone ?? _phone,
    userType: userType ?? _userType,
    image: image ?? _image,
    licences: licences ?? _licences,
    accreditations: accreditations ?? _accreditations,
    gender: gender ?? _gender,
    language: language ?? _language,
    exprienceInYears: exprienceInYears ?? _exprienceInYears,
    exprienceSummary: exprienceSummary ?? _exprienceSummary,
    userRedus: userRedus ?? _userRedus,
    bankName: bankName ?? _bankName,
    accountHolderName: accountHolderName ?? _accountHolderName,
    accountNo: accountNo ?? _accountNo,
    bankBranch: bankBranch ?? _bankBranch,
  );

  num? get id => _id;

  String? get firstName => _firstName;

  String? get email => _email;

  String? get phone => _phone;

  String? get userType => _userType;

  String? get image => _image;

  List<dynamic>? get licences => _licences;

  List<dynamic>? get accreditations => _accreditations;

  String? get gender => _gender;

  String? get language => _language;

  num? get exprienceInYears => _exprienceInYears;

  String? get exprienceSummary => _exprienceSummary;

  num? get userRedus => _userRedus;

  dynamic get bankName => _bankName;

  dynamic get accountHolderName => _accountHolderName;

  dynamic get accountNo => _accountNo;

  dynamic get bankBranch => _bankBranch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['user_type'] = _userType;
    map['image'] = _image;
    if (_licences != null) {
      map['licences'] = _licences?.map((v) => v.toJson()).toList();
    }
    if (_accreditations != null) {
      map['accreditations'] = _accreditations?.map((v) => v.toJson()).toList();
    }
    map['gender'] = _gender;
    map['language'] = _language;
    map['exprience_in_years'] = _exprienceInYears;
    map['exprience_summary'] = _exprienceSummary;
    map['user_redus'] = _userRedus;
    map['bank_name'] = _bankName;
    map['account_holder_name'] = _accountHolderName;
    map['account_no'] = _accountNo;
    map['bank_branch'] = _bankBranch;
    return map;
  }
}
