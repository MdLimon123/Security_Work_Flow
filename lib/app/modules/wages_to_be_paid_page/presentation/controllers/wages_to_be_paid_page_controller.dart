import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WagesToBePaidPageController extends GetxController {
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController accountHolderNameTEC = TextEditingController();
  final TextEditingController accountNumberTEC = TextEditingController();

  @override
  void onClose() {
    bankNameTEC.dispose();
    accountHolderNameTEC.dispose();
    accountNumberTEC.dispose();
    super.onClose();
  }
}
