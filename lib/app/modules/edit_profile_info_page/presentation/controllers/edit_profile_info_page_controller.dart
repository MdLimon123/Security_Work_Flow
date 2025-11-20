import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileInfoPageController extends GetxController {
  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneNumTEC = TextEditingController();
  final TextEditingController addressTEC = TextEditingController();

  String selectedLanguage = "";
  String selectedGender = "";

  bool sendNotifications = false;

  void setLanguage(String value) {
    selectedLanguage = value;
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

  @override
  void onClose() {
    fullNameTEC.dispose();
    phoneNumTEC.dispose();
    addressTEC.dispose();
    super.onClose();
  }
}
