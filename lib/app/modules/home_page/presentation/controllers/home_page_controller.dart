import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/home_page/data/models/dash_board_info_model.dart';
import 'package:flutter_security_workforce/app/modules/home_page/data/models/profile_info_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  bool dashBoardInfoLoaded = true;
  bool profileInfoLoaded = true;

  DashBoardInfoModel dashBoardInfoModel = DashBoardInfoModel();
  ProfileInfoModel profileInfoModel = ProfileInfoModel();

  late Position currentPosition;

  Future<void> loadDashBoardInfo() async {
    dashBoardInfoLoaded = false;
    update();

    try {
      DioClient dioClient = DioClient();

      dashBoardInfoModel = DashBoardInfoModel.fromJson(
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

  Future<void> loadProfileInfo() async {
    profileInfoLoaded = false;
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
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    profileInfoLoaded = true;
    update();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.snackbar(
        "Error",
        "Location services are disabled.",
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Error",
          "Location services denied.",
          backgroundColor: AppColors.primaryRed,
          colorText: AppColors.primaryWhite,
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Error",
        "Location permissions are permanently denied, we cannot request permissions.",
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    currentPosition = await Geolocator.getCurrentPosition();

    // print(
    //   "Sajid testing latitude ${currentPosition.latitude} and longitude ${currentPosition.longitude}",
    // );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await _determinePosition();
    await loadDashBoardInfo();
    await loadProfileInfo();
  }
}
