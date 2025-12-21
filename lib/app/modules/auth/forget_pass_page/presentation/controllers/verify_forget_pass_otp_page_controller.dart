import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class VerifyForgetPassOtpPageController extends GetxController {
  final TextEditingController pinPutController = TextEditingController();

  bool verifyInProgress = false;

  Future<void> verifyOTP({
    required BuildContext context,
    required String email,
  }) async {
    verifyInProgress = true;
    update();

    DioClient dioClient = DioClient();

    try {
      print("sajid testing ${pinPutController.text}");

      dynamic data = await dioClient.post(
        ApiEndpoints.getVerifyForgetPassUrl(email: email),
        data: {"otp": pinPutController.text},
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      await Get.toNamed(AppRoutes.newPassRoute, arguments: data["access"]);
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
    }

    verifyInProgress = false;
    update();
  }

  @override
  void onClose() {
    // pinPutController.dispose();
    super.onClose();
  }
}
