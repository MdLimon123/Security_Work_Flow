import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherAccrediationsPageController extends GetxController {
  String selectedLicenseType = "";

  final TextEditingController expireDateTEC = TextEditingController();

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  @override
  void onClose() {
    expireDateTEC.dispose();
    super.onClose();
  }
}
