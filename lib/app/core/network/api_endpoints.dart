class ApiEndpoints {
  static const String _baseUrl = "http://10.10.12.15:8001";

  static String get getBaseUrl => _baseUrl;

  static const String dashboardDataUrl =
      "$_baseUrl/api/jobs/user-dashboard-data/";

  static const String profileInfoUrl = "$_baseUrl/api/accounts/user-profile/";

  static const String loginUrl = "$_baseUrl/api/auth/login/";

  static const String forgetPassUrl = "$_baseUrl/api/auth/forgetpassword/";

  static const String resetPassUrl = "$_baseUrl/api/auth/reset_password/";

  static const String licenceTypeListUrl = "$_baseUrl/api/jobs/licence-types/";

  static const String accreditationUrl = "$_baseUrl/api/accounts/certificates/";

  static const String accreditationTypeListUrl =
      "$_baseUrl/api/jobs/certificate-types/";

  static const String addLicenceUrl = "$_baseUrl/api/accounts/licences/";

  static const String profileUpdateUrl =
      "$_baseUrl/api/accounts/profile-update/";

  static String getSignupUrl({String? referCode}) {
    return "$_baseUrl/api/auth/signup/${referCode != null ? "?referral_token=$referCode" : ""}";
  }

  static String getVerifySignupUrl({required String email}) {
    return "$_baseUrl/api/auth/verify/$email/";
  }

  static String getVerifyForgetPassUrl({required String email}) {
    return "$_baseUrl/api/auth/vefiry_for_forget/$email/";
  }

  static const String jobListUrl = "$_baseUrl/api/jobs/user-job-posts/";

  static const String licenseUrl = "$_baseUrl/api/accounts/licences/";

  static const String locationUrl = "$_baseUrl/api/accounts/location-update/";

  static const String certificateTypeUrl =
      "$_baseUrl/api/jobs/certificate-types/";

  static const String cardUrl = "$_baseUrl/api/accounts/get-card-info/";

  static const String jobHistoryUrl = "$_baseUrl/api/jobs/user_Jobs_history/";

  static String applyJob({required String jobId}) =>
      "$_baseUrl/api/jobs/user-job-posts/$jobId/";

  static const String referalListUrl =
      "$_baseUrl/api/accounts/user-refarral-users/";

  static const String chatListUrl = "$_baseUrl/api/chat-note/chat-list/?page=1";

  static String getMessageHistoryUrl({required String conversationId}) =>
      "$_baseUrl/api/chat-note/message-list/$conversationId/";

  static String engagementListUrl = "$_baseUrl/api/jobs/company-engagements/";
  static String amendContractUrl =
      "$_baseUrl/api/jobs/user-engagements-ammends/";

  static const String myJobListUrl = "$_baseUrl/api/jobs/user/my-jobs/";

  static const String customSupport = "$_baseUrl/api/jobs/support-message/";
  static const String customSupportSend = "$_baseUrl/api/jobs/support-message/";
  static const String referralUrl = "$_baseUrl/api/accounts/user-refarral-code/";

  static String acceptJobUrl({required String id}) =>
      "$_baseUrl/api/jobs/user/my-jobs/$id/";

  static String rejectJobUrl({required String id}) =>
      "$_baseUrl/api/jobs/user/my-jobs/$id/";
  static String uploadSignatureUrl({required String id}) =>
      "$_baseUrl/api/jobs/company-engagements-details/$id/";

  static String chatSocketUrl({required String token}) =>
      "ws://10.10.12.15:8001/ws/asc/update_chat_messages/?token=$token";
}
