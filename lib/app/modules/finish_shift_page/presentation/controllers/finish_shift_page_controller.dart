import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';

class FinishShiftPageController extends GetxController {
  int communicationSelectedIndex = 1;
  int paymentSelectedIndex = 1;
  int payRatesSelectedIndex = 1;
  int professionalismSelectedIndex = 1;
  int jobSupportSelectedIndex = 1;

  final commentTextFieldController = TextEditingController();

  bool isLoading = false;

  void updateCommunicationSelectedIndex({required int value}) {
    communicationSelectedIndex = value;
    update();
  }

  void updatePaymentSelectedIndex({required int value}) {
    paymentSelectedIndex = value;
    update();
  }

  void updatePayRatesSelectedIndex({required int value}) {
    payRatesSelectedIndex = value;
    update();
  }

  void updateProfessionalismSelectedIndex({required int value}) {
    professionalismSelectedIndex = value;
    update();
  }

  void updateJobSupportSelectedIndex({required int value}) {
    jobSupportSelectedIndex = value;
    update();
  }

  var isRating = false.obs;

  Future<void> submitRating({
    required BuildContext context,
    required String id,
  }) async {
    isLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.post(
        ApiEndpoints.submitReivewUrl(id: id),

        data: {
          "comunication": communicationSelectedIndex,
          "pay_rate": paymentSelectedIndex,
          "professionalism": payRatesSelectedIndex,
          "reliability": professionalismSelectedIndex,
          "job_support": jobSupportSelectedIndex,
        },
      );

      commentTextFieldController.clear();

      Get.snackbar(
        "Success",
        "Rating submitted successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

       isRating.value = true;

      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading = false;
    update();
  }
}
