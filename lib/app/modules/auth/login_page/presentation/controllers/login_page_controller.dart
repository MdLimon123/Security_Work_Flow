import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../routes/app_routes.dart';

class LoginPageController extends GetxController {
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  bool obscurePass = true;
  bool rememberMe = false;
  bool signInInProgress = false;

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    update();
  }

  void toggleObscurePass() {
    obscurePass = !obscurePass;
    update();
  }

  Future<void> login({required BuildContext context}) async {
    signInInProgress = true;
    update();

    DioClient dioClient = DioClient(baseUrl: ApiEndpoints.loginUrl);

    try {
      dynamic data = await dioClient.post(
        ApiEndpoints.loginUrl,
        data: {"email": emailTEC.text, "password": passwordTEC.text},
      );

      LoginResponseModel loginResponse = LoginResponseModel.fromJson(data);

      if (rememberMe) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        await sharedPreferences.setString(
          AppKeys.loginKey,
          loginResponse.toJson().toString(),
        );
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginResponse.message ?? ""),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }

      Get.offAllNamed(AppRoutes.bottomNavbarRoute);
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

    signInInProgress = false;
    update();
  }

  @override
  void onClose() {
    emailTEC.dispose();
    passwordTEC.dispose();

    super.onClose();
  }
}
