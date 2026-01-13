import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/customer_support_page/presentation/model/custom_suppport_message_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/data/models/profile_info_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/data/models/referral_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_routes.dart';

class ProfilePageController extends GetxController {
  bool notificationOn = false;

  bool dataLoaded = true;

  bool isCustomSupportLoading = false;

  ProfileInfoModel profileInfoModel = ProfileInfoModel();
  TextEditingController referralController = TextEditingController();

  final sendMessageController = TextEditingController();

  SupportMessageResponse customSupportModel = SupportMessageResponse();

  ReferralModel referralModel = ReferralModel();



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
    await fetchCustomSupport();
    await fetchReferral();
  }

  Future<void> fetchReferral() async {
    try {
      DioClient dioClient = DioClient();

      referralModel = ReferralModel.fromJson(
        await dioClient.get(ApiEndpoints.referralUrl),
      );

         referralController.text =
        "https://example.com/signin/?${referralModel.code}";

 
    update(); 
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
  }

  Future<void> fetchCustomSupport() async {
    isCustomSupportLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      customSupportModel = SupportMessageResponse.fromJson(
        await dioClient.get(ApiEndpoints.customSupport),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryGreen,
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

    isCustomSupportLoading = false;
    update();
  }

  Future<void> submitCustomSupport() async {
    final text = sendMessageController.text.trim();
    if (text.isEmpty) return;

    final localMessage = SupportMessage(
      id: 0,
      fullName: profileInfoModel.data!.fullName!,
      email: profileInfoModel.data!.email!,
      message: text,
      createdAt: DateTime.now().toIso8601String(),
    );

    customSupportModel.messages ??= [];
    customSupportModel.messages!.add(localMessage);
    sendMessageController.clear();
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.post(
        ApiEndpoints.customSupportSend,
        data: {
          "full_name": localMessage.fullName,
          "email": localMessage.email,
          "message": localMessage.message,
        },
      );
    } on AppException catch (e) {
      Get.snackbar("Error", e.message);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
