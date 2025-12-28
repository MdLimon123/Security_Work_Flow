import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/home_page/data/models/profile_info_model.dart';
import 'package:get/get.dart';

class WagesToBePaidPageController extends GetxController {
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController accountHolderNameTEC = TextEditingController();
  final TextEditingController accountNumberTEC = TextEditingController();

  bool submitting = false;

  Future<void> updateBankDetails() async {
    submitting = true;
    update();
    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "bank_name": bankNameTEC.text.trim(),
          "account_holder_name": accountHolderNameTEC.text.trim(),
          "account_no": accountNumberTEC.text.trim(),
        },
      );

      Get.snackbar(
        "Success",
        "Updated",
        backgroundColor: AppColors.primaryGreen,
      );
    } on AppException catch (e) {
      Get.snackbar("Error", e.message, backgroundColor: AppColors.primaryRed);
    }

    submitting = false;
    update();
  }

  Future<void> _fetchBankDetails() async {
    try {
      ProfileInfoModel profileInfoModel = ProfileInfoModel.fromJson(
        await DioClient().get(ApiEndpoints.profileInfoUrl),
      );
      bankNameTEC.text = profileInfoModel.data?.bankName ?? "";
      accountHolderNameTEC.text =
          profileInfoModel.data?.accountHolderName ?? "";
      accountNumberTEC.text = profileInfoModel.data?.accountNo ?? "";
      update();
    } on AppException catch (e) {
      Get.snackbar("Error", e.message, backgroundColor: AppColors.primaryRed);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await _fetchBankDetails();
  }

  @override
  void onClose() {
    bankNameTEC.dispose();
    accountHolderNameTEC.dispose();
    accountNumberTEC.dispose();
    super.onClose();
  }
}
