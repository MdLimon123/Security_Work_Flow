import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardEditPageController extends GetxController {
  final TextEditingController cardHolderNameTEC = TextEditingController();
  final TextEditingController cardNumberTEC = TextEditingController();
  final TextEditingController expireDateTEC = TextEditingController();
  final TextEditingController cvvTEC = TextEditingController();
  final TextEditingController billingAddressTEC = TextEditingController();

  @override
  void onClose() {
    cardHolderNameTEC.dispose();
    cardNumberTEC.dispose();
    expireDateTEC.dispose();
    cvvTEC.dispose();
    billingAddressTEC.dispose();
    super.onClose();
  }
}
