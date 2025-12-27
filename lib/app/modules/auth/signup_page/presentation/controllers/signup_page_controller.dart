import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/signup_page/data/models/signup_input_data_model.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPageController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameTec = TextEditingController();
  final TextEditingController emailTec = TextEditingController();
  final TextEditingController passwordTec = TextEditingController();
  final TextEditingController confirmPasswordTec = TextEditingController();
  final TextEditingController referTec = TextEditingController();

  bool obscurePass = true;
  bool obscureConfirmPass = true;
  bool signupInProgress = false;

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    update();
  }

  void toggleObscureConfirmPass() {
    obscureConfirmPass = !obscureConfirmPass;
    update();
  }

  Future<void> signup({required BuildContext context}) async {
    signupInProgress = true;
    update();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove(AppKeys.accessTokenKey);
    await sharedPreferences.remove(AppKeys.loginKey);

    if (confirmPasswordTec.text != passwordTec.text ||
        confirmPasswordTec.text.isEmpty ||
        passwordTec.text.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Confirm password and password must much and non empty",
            ),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }
      signupInProgress = false;
      update();
      return;
    }

    DioClient dioClient = DioClient();

    try {
      await dioClient.post(
        ApiEndpoints.getSignupUrl(
          referCode: referTec.text.isEmpty ? null : referTec.text,
        ),
        data: SignupInputDataModel(
          firstName: nameTec.text,
          email: emailTec.text,
          password: passwordTec.text,
        ).toJson(),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Check your email for otp"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      Get.toNamed(
        AppRoutes.verifyRegistrationOtpRoute,
        arguments: emailTec.text,
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

    signupInProgress = false;
    update();
  }

  @override
  void onClose() {
    nameTec.dispose();
    emailTec.dispose();
    passwordTec.dispose();
    confirmPasswordTec.dispose();
    referTec.dispose();
    super.onClose();
  }
}
