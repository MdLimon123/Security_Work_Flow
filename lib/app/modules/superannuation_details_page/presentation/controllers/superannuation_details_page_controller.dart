import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';

class SuperannuationDetailsPageController extends GetxController {
  final TextEditingController taxFileNumTEC = TextEditingController();
  final TextEditingController fundNameTEC = TextEditingController();
  final TextEditingController fundUSITEC = TextEditingController();
  final TextEditingController memberNumberTEC = TextEditingController();
  final TextEditingController dateOfBirthTEC = TextEditingController();

  bool isLoading = false;

  Future<void> saveAndUpdate() async {
    isLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "tax_file_number": taxFileNumTEC.text,
          "fund_name": fundNameTEC.text,
          "fund_usi": fundUSITEC.text,
          "sup_member_no": memberNumberTEC.text,
          "date_of_birth": dateOfBirthTEC.text,
        },
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    isLoading = false;
    update();
  }

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
