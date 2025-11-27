class ApiEndpoints {
  static const String _baseUrl = "http://10.10.12.15:8001/api";

  static const String loginUrl = "$_baseUrl/auth/login/";

  static const String forgetPassUrl = "$_baseUrl/auth/forgetpassword/";

  static const String resetPassUrl = "$_baseUrl/auth/reset_password/";

  static String getSignupUrl({String? referCode}) {
    return "$_baseUrl/auth/signup/${referCode != null ? "?referral_token=$referCode" : ""}";
  }

  static String getVerifySignupUrl({required String email}) {
    return "$_baseUrl/auth/verify/$email/";
  }

  static String getVerifyForgetPassUrl({required String email}) {
    return "$_baseUrl/auth/vefiry_for_forget/$email/";
  }
}
