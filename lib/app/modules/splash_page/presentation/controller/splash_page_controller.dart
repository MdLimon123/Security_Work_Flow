import 'dart:convert';

import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _moveToNextPage();
  }

  Future<void> _moveToNextPage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(AppKeys.loginKey) != null) {
      LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode((sharedPreferences.getString(AppKeys.loginKey) ?? "")),
      );

      if (loginResponseModel.success ?? false) {
        await Future.delayed(Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.bottomNavbarRoute);
        return;
      }
    }

    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed(AppRoutes.onBoardingGetStartedRoute);
  }

  // Future<void> _moveToNextPage() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   final loginData = sharedPreferences.getString(AppKeys.loginKey);

  //   if (loginData != null) {
  //     LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
  //       jsonDecode(loginData),
  //     );

  //     await Future.delayed(const Duration(seconds: 1));

  //     if (loginResponseModel.verified ?? false) {

  //       Get.offAllNamed(AppRoutes.bottomNavbarRoute);
  //     } else {

  //       Get.offAllNamed(
  //         AppRoutes.verificationScreen,

  //       );
  //     }
  //     return;
  //   }

  //   await Future.delayed(const Duration(seconds: 2));
  //   Get.offAllNamed(AppRoutes.onBoardingGetStartedRoute);
  // }


  // Future<void> _moveToNextPage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(AppKeys.accessTokenKey);
  //   final loginData = prefs.getString(AppKeys.loginKey);

  //   await Future.delayed(const Duration(seconds: 1));

  //   // 🔹 No token or no saved login → Onboarding
  //   if (token == null || token.trim().isEmpty || loginData == null) {
  //     Get.offAllNamed(AppRoutes.onBoardingGetStartedRoute);
  //     return;
  //   }

  //   // 🔹 Parse saved login response
  //   final loginResponse = LoginResponseModel.fromJson(jsonDecode(loginData));

  //   // 🔹 Already logged in → check verified status
  //   if (loginResponse.verified ?? false) {
  //     Get.offAllNamed(AppRoutes.bottomNavbarRoute);
  //   } else {
  //     Get.offAllNamed(AppRoutes.onBoardingGetStartedRoute);
  //   }
  // }
}
