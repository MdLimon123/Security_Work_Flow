import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class VerifyRegistrationOtpPageController extends GetxController {
  final TextEditingController pinPutController = TextEditingController();

  bool verifyInProgress = false;

  Future<void> verify({
    required String email,
    required BuildContext context,
  }) async {
    verifyInProgress = true;
    update();

    DioClient dioClient = DioClient();

    try {
      await dioClient.post(
        ApiEndpoints.getVerifySignupUrl(email: email),
        data: {"otp": pinPutController.text},
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account verified"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );

        Get.offAllNamed(AppRoutes.loginRoute);
      }
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
