import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerSupportPageController extends GetxController {
  final TextEditingController messageTEC = TextEditingController();

  @override
  void onClose() {
    messageTEC.dispose();
    super.onClose();
  }
}
