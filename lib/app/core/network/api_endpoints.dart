class ApiEndpoints {
  static const String _baseUrl = "http://10.10.12.15:8001/api";

  static const String loginUrl = "$_baseUrl/auth/login/";

  static String getSignupUrl({String? referCode}) {
    return "$_baseUrl/auth/signup/${referCode != null ? "?referral_token=$referCode" : ""}";
  }

  static String getVerifySignupUrl({required String email}) {
    return "$_baseUrl/auth/verify/$email/";
  }
}
