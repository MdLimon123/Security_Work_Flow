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
}
