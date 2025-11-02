class AppAssets {
  static const String splashPageHeader = "assets/images/slpash_header.svg";
  static const String securiverseIcon = "assets/icons/securiverse_icon.png";
  static const String securityGuardImg = "assets/images/security_guard_img.jpg";
  static const String orangeTickIcon = "assets/icons/orange_tick_icon.svg";
  static const String uploadProfileImageImg =
      "assets/images/upload_profile_image_img.svg";

  static String getProfileVerifyProgressImg({required int progressCompleted}) {
    return "assets/images/profile_verify_progress_img_0${progressCompleted + 1}.svg";
  }

  static const String uploadBackFrontImageLicenseImage =
      "assets/images/upload_back_front_image_license.svg";
  static const String uploadBackFrontImageAccreditationImage =
      "assets/images/upload_back_front_image_accreditation.svg";

  static const String pauseIcon = "assets/icons/pause_icon.svg";
  static const String cancelIcon = "assets/icons/cancel_icon.svg";
  static const String pdfIcon = "assets/icons/pdf_icon.svg";
}
