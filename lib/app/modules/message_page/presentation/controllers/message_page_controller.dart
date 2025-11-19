import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessagePageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
