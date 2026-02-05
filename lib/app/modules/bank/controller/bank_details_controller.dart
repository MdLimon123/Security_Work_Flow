import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';

class BankDetailsController extends GetxController {
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController accountHolderNameTEC = TextEditingController();
  final TextEditingController accountNumberTEC = TextEditingController();
  final TextEditingController bsbNumberTEC = TextEditingController();

  bool nextButtonInProgress = false;

  Future<void> submitFifthStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "bank_name": bankNameTEC.text.toString().trim(),
          "account_holder_name": accountHolderNameTEC.text.toString().trim(),
          "account_no": accountNumberTEC.text.toString().trim(),
          "bank_branch": bsbNumberTEC.text.toString().trim(),
        },
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
      nextButtonInProgress = false;
      update();
      Get.back();
    } on AppException catch (e) {
      log(e.message);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      nextButtonInProgress = false;
      update();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      nextButtonInProgress = false;
      update();
    }
  }
}
