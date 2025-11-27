import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/dio_client.dart';

class ForgetPasswordPageController extends GetxController {
  final TextEditingController emailTec = TextEditingController();

  bool forgetPassInProgress = false;

  Future<void> forgetPass({required BuildContext context}) async {
    forgetPassInProgress = true;
    update();

    DioClient dioClient = DioClient();

    try {
      dynamic data = await dioClient.post(
        ApiEndpoints.forgetPassUrl,
        data: {"email": emailTec.text.trim()},
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      Get.toNamed(
        AppRoutes.verifyForgetPassRoute,
        arguments: emailTec.text.trim().toString(),
      );
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

    forgetPassInProgress = false;
    update();
  }

  @override
  void onClose() {
    emailTec.dispose();
    super.onClose();
  }
}
