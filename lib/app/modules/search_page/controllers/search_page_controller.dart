import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  int selectedLicense = -1;
  int selectedAccreditation = -1;

  List<int> payRange = [16, 32];

  void setSelectedAccreditation({required int index}) {
    if (index == selectedAccreditation) {
      selectedAccreditation = -1;
    } else {
      selectedAccreditation = index;
    }
    update();
  }

  void setSelectedLicense({required int index}) {
    if (index == selectedLicense) {
      selectedLicense = -1;
    } else {
      selectedLicense = index;
    }
    update();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
