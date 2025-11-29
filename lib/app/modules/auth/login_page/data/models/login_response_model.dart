/// success : true
/// verified : false
/// message : "login successfull!"
/// access : ""
/// refresh : ""
/// guard_details : {}

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

  // ------------------------------
  // Getters
  // ------------------------------
  bool? get success => _success;

  bool? get verified => _verified;

  String? get message => _message;

  String? get access => _access;

  String? get refresh => _refresh;

  GuardDetails? get guardDetails => _guardDetails;

  // ------------------------------
  // Setters
  // ------------------------------
  void setSuccess(bool value) => _success = value;

  void setVerified(bool value) => _verified = value;

  void setMessage(String value) => _message = value;

  void setAccess(String value) => _access = value;

  void setRefresh(String value) => _refresh = value;

  void setGuardDetails(GuardDetails value) => _guardDetails = value;

  // ------------------------------
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

// ============================================================================
// GUARD DETAILS
// ============================================================================

class GuardDetails {
  GuardDetails({int? id, Candidate? candidate}) {
    _id = id;
    _candidate = candidate;
  }

  GuardDetails.fromJson(dynamic json) {
    _id = json['id'];
    _candidate = json['candidate'] != null
        ? Candidate.fromJson(json['candidate'])
        : null;
  }

  int? _id;
  Candidate? _candidate;

  // Getters
  int? get id => _id;

  Candidate? get candidate => _candidate;

  // Setters
  void setId(int value) => _id = value;

  void setCandidate(Candidate value) => _candidate = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_candidate != null) {
      map['candidate'] = _candidate?.toJson();
    }
    return map;
  }
}

// ============================================================================
// CANDIDATE
// ============================================================================

class Candidate {
  Candidate({
    int? id,
    String? firstName,
    String? email,
    dynamic phone,
    String? userType,
    List<dynamic>? licences,
    List<dynamic>? accreditations,
    String? gender,
    dynamic language,
    int? exprienceInYears,
    String? exprienceSummary,
    int? userRedus,
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
    _licences = json['licences'] ?? [];
    _accreditations = json['accreditations'] ?? [];
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

  int? _id;
  String? _firstName;
  String? _email;
  dynamic _phone;
  String? _userType;
  List<dynamic>? _licences;
  List<dynamic>? _accreditations;
  String? _gender;
  dynamic _language;
  int? _exprienceInYears;
  String? _exprienceSummary;
  int? _userRedus;
  dynamic _bankName;
  dynamic _accountHolderName;
  dynamic _accountNo;
  dynamic _bankBranch;

  // ------------------------------
  // Getters
  // ------------------------------
  int? get id => _id;

  String? get firstName => _firstName;

  String? get email => _email;

  dynamic get phone => _phone;

  String? get userType => _userType;

  List<dynamic>? get licences => _licences;

  List<dynamic>? get accreditations => _accreditations;

  String? get gender => _gender;

  dynamic get language => _language;

  int? get exprienceInYears => _exprienceInYears;

  String? get exprienceSummary => _exprienceSummary;

  int? get userRedus => _userRedus;

  dynamic get bankName => _bankName;

  dynamic get accountHolderName => _accountHolderName;

  dynamic get accountNo => _accountNo;

  dynamic get bankBranch => _bankBranch;

  // ------------------------------
  // Setters
  // ------------------------------
  void setId(int value) => _id = value;

  void setFirstName(String value) => _firstName = value;

  void setEmail(String value) => _email = value;

  void setPhone(dynamic value) => _phone = value;

  void setUserType(String value) => _userType = value;

  void setLicences(List<dynamic> value) => _licences = value;

  void setAccreditations(List<dynamic> value) => _accreditations = value;

  void setGender(String value) => _gender = value;

  void setLanguage(dynamic value) => _language = value;

  void setExprienceInYears(int value) => _exprienceInYears = value;

  void setExprienceSummary(String value) => _exprienceSummary = value;

  void setUserRedus(int value) => _userRedus = value;

  void setBankName(dynamic value) => _bankName = value;

  void setAccountHolderName(dynamic value) => _accountHolderName = value;

  void setAccountNo(dynamic value) => _accountNo = value;

  void setBankBranch(dynamic value) => _bankBranch = value;

  // ------------------------------
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['user_type'] = _userType;
    map['licences'] = _licences;
    map['accreditations'] = _accreditations;
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
