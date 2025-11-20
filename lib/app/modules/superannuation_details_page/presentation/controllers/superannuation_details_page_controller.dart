import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SuperannuationDetailsPageController extends GetxController {
  final TextEditingController taxFileNumTEC = TextEditingController();
  final TextEditingController fundNameTEC = TextEditingController();
  final TextEditingController fundUSITEC = TextEditingController();
  final TextEditingController memberNumberTEC = TextEditingController();
  final TextEditingController dateOfBirthTEC = TextEditingController();

  @override
  void onClose() {
    taxFileNumTEC.dispose();
    fundNameTEC.dispose();
    fundUSITEC.dispose();
    memberNumberTEC.dispose();
    dateOfBirthTEC.dispose();
    super.onClose();
  }
}
