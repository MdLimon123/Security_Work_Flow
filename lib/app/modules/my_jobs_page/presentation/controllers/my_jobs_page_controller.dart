import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyJobsPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
