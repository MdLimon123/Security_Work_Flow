import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_four_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_one_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_three_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_two_page.dart';
import 'package:get/get.dart';

class ProfileVerificationPageController extends GetxController {
  List<Widget> pages = [
    StepOnePage(),
    StepTwoPage(),
    StepThreePage(),
    StepFourPage(),
  ];

  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController summaryTEC = TextEditingController();
  final TextEditingController licenseExpireTEC = TextEditingController();
  final TextEditingController accreditationTEC = TextEditingController();

  int pageIndex = 0;

  bool sendNotifications = false;

  String selectedGender = "";

  String selectedLanguage = "";

  String selectedYearsOfExperience = "";

  String selectedStateOrTerritory = "";

  String selectedLicenseType = "";

  String selectedAccreditation = "";

  void setSelectedAccreditation(String value) {
    selectedAccreditation = value;
    update();
  }

  void setGender(String value) {
    selectedGender = value;
    update();
  }

  void toggleSendNotifications() {
    sendNotifications = !sendNotifications;
    update();
  }

  void setLanguage(String value) {
    selectedLanguage = value;
    update();
  }

  void setStateOrTerritory(String value) {
    selectedStateOrTerritory = value;
    update();
  }

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  void setYearsOfExperience(String value) {
    selectedYearsOfExperience = value;
    update();
  }

  void increasePageIndex() {
    pageIndex++;
    update();
  }

  void decreasePageIndex() {
    if (pageIndex > 0) {
      pageIndex--;
    }
    update();
  }

  @override
  void onClose() {
    fullNameTEC.dispose();
    phoneTEC.dispose();
    summaryTEC.dispose();
    licenseExpireTEC.dispose();
    accreditationTEC.dispose();
    super.onClose();
  }
}
