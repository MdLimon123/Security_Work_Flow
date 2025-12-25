import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/data/models/profile_info_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class ProfilePageController extends GetxController {
  bool notificationOn = false;

  bool dataLoaded = true;

  ProfileInfoModel profileInfoModel = ProfileInfoModel();

  void toggleNotification() {
    notificationOn = !notificationOn;
    update();
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(AppKeys.loginKey);
    Get.offAllNamed(AppRoutes.onBoardingRoute);
  }

  Future<void> fetchProfileInfo() async {
    dataLoaded = false;
    update();

    try {
      DioClient dioClient = DioClient();

      profileInfoModel = ProfileInfoModel.fromJson(
        await dioClient.get(ApiEndpoints.profileInfoUrl),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    dataLoaded = true;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchProfileInfo();
  }
}
