import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessagePageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();
  final TextEditingController messageTEC = TextEditingController();

  @override
  void onClose() {
    searchTEC.dispose();
    messageTEC.dispose();
    super.onClose();
  }
}
