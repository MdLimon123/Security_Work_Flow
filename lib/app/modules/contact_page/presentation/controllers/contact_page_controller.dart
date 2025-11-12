import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  int selectedIndex = 0;

  void updateIndex(int value) {
    selectedIndex = value;
    update();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
