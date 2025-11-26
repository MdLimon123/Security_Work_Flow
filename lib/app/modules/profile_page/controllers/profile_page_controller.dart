import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class ProfilePageController extends GetxController {
  bool notificationOn = false;

  void toggleNotification() {
    notificationOn = !notificationOn;
    update();
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppKeys.loginKey);
    Get.offAllNamed(AppRoutes.onBoardingRoute);
  }
}
