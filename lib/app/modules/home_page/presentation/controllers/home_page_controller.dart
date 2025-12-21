import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/home_page/data/models/profile_info_model.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  bool dashBoardInfoLoaded = true;

  ProfileInfoModel profileInfoModel = ProfileInfoModel();

  Future<void> loadDashBoardInfo() async {
    dashBoardInfoLoaded = false;
    update();

    try {
      DioClient dioClient = DioClient();

      profileInfoModel = ProfileInfoModel.fromJson(
        await dioClient.get(ApiEndpoints.dashboardDataUrl),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    dashBoardInfoLoaded = true;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadDashBoardInfo();
  }
}
