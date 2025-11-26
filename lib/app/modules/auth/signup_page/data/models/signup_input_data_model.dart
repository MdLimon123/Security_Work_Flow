/// first_name : "Sajid Hossain"
/// email : "sajidrec@gmail.com"
/// password : "12345678"
/// user_type : "guard"
library;

class SignupInputDataModel {
  SignupInputDataModel({
    String? firstName,
    String? email,
    String? password,
    String? userType = "guard",
  }) {
    _firstName = firstName;
    _email = email;
    _password = password;
    _userType = userType;
  }

  SignupInputDataModel.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _email = json['email'];
    _password = json['password'];
    _userType = json['user_type'];
  }

  String? _firstName;
  String? _email;
  String? _password;
  String? _userType;

  SignupInputDataModel copyWith({
    String? firstName,
    String? email,
    String? password,
    String? userType = "guard",
  }) => SignupInputDataModel(
    firstName: firstName ?? _firstName,
    email: email ?? _email,
    password: password ?? _password,
    userType: userType ?? _userType,
  );

  String? get firstName => _firstName;

  String? get email => _email;

  String? get password => _password;

  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['email'] = _email;
    map['password'] = _password;
    map['user_type'] = _userType;
    return map;
  }
}
