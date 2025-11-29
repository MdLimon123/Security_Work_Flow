import 'dart:io';

/// first_name : "Sajid"
/// email : "sajidrec@gmail.com"
/// phone : "8801789511097"
/// image : ""
/// gender : "male"
/// language : "english"
/// exprience_in_years : "3"
/// exprience_summary : "the quikc brown fox"
/// user_redus : "50"
/// bank_name : "Brac Bank"
/// account_holder_name : "Sajid Hossain"
/// account_no : "1111"
/// bank_branch : "savar"

class VerificationDetailsModel {
  VerificationDetailsModel({
    String? firstName,
    String? email,
    String? phone,
    File? image,
    String? gender,
    String? language,
    String? exprienceInYears,
    String? exprienceSummary,
    String? userRedus,
    String? bankName,
    String? accountHolderName,
    String? accountNo,
    String? bankBranch,
  }) {
    _firstName = firstName;
    _email = email;
    _phone = phone;
    _image = image;
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

  VerificationDetailsModel.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
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

  String? _firstName;
  String? _email;
  String? _phone;
  File? _image;
  String? _gender;
  String? _language;
  String? _exprienceInYears;
  String? _exprienceSummary;
  String? _userRedus;
  String? _bankName;
  String? _accountHolderName;
  String? _accountNo;
  String? _bankBranch;

  // -------------------------
  // Getters
  // -------------------------
  String? get firstName => _firstName;

  String? get email => _email;

  String? get phone => _phone;

  File? get image => _image;

  String? get gender => _gender;

  String? get language => _language;

  String? get exprienceInYears => _exprienceInYears;

  String? get exprienceSummary => _exprienceSummary;

  String? get userRedus => _userRedus;

  String? get bankName => _bankName;

  String? get accountHolderName => _accountHolderName;

  String? get accountNo => _accountNo;

  String? get bankBranch => _bankBranch;

  // -------------------------
  // Java-Style Setters
  // -------------------------
  void setFirstName(String? value) => _firstName = value;

  void setEmail(String? value) => _email = value;

  void setPhone(String? value) => _phone = value;

  void setImage(File? value) => _image = value;

  void setGender(String? value) => _gender = value;

  void setLanguage(String? value) => _language = value;

  void setExprienceInYears(String? value) => _exprienceInYears = value;

  void setExprienceSummary(String? value) => _exprienceSummary = value;

  void setUserRedus(String? value) => _userRedus = value;

  void setBankName(String? value) => _bankName = value;

  void setAccountHolderName(String? value) => _accountHolderName = value;

  void setAccountNo(String? value) => _accountNo = value;

  void setBankBranch(String? value) => _bankBranch = value;

  VerificationDetailsModel copyWith({
    String? firstName,
    String? email,
    String? phone,
    File? image,
    String? gender,
    String? language,
    String? exprienceInYears,
    String? exprienceSummary,
    String? userRedus,
    String? bankName,
    String? accountHolderName,
    String? accountNo,
    String? bankBranch,
  }) => VerificationDetailsModel(
    firstName: firstName ?? _firstName,
    email: email ?? _email,
    phone: phone ?? _phone,
    image: image ?? _image,
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
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
