import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LicenseAndCertificatesPageController extends GetxController {
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
