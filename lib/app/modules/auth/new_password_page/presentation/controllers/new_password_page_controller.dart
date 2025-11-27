import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:get/get.dart';

import '../../../../../core/network/dio_client.dart';
import '../views/password_changed_message_page.dart';

class NewPasswordPageController extends GetxController {
  final TextEditingController passwordTec = TextEditingController();
  final TextEditingController confirmPasswordTec = TextEditingController();

  bool obscurePass = true;
  bool obscureConfirmPass = true;

  bool resetPassInProgress = false;

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    update();
  }

  void toggleObscureConfirmPass() {
    obscureConfirmPass = !obscureConfirmPass;
    update();
  }

  Future<void> reset({
    required BuildContext context,
    required String accessToken,
  }) async {
    resetPassInProgress = true;
    update();

    if (passwordTec.text.isEmpty ||
        confirmPasswordTec.text.isEmpty ||
        passwordTec.text != confirmPasswordTec.text) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password doesn't match or empty."),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      resetPassInProgress = false;
      update();

      return;
    }

    DioClient dioClient = DioClient();

    try {
      dynamic data = await dioClient.post(
        ApiEndpoints.resetPassUrl,
        data: {"new_password": passwordTec.text},
        headers: {"Authorization": "Bearer $accessToken"},
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"]),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      await Get.offAll(PasswordChangedMessagePage());
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

    resetPassInProgress = false;
    update();
  }

  @override
  void onClose() {
    passwordTec.dispose();
    confirmPasswordTec.dispose();
    super.onClose();
  }
}
