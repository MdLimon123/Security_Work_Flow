import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/auth/login_page/data/models/login_response_model.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_five_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_four_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_one_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_three_page.dart';
import 'package:flutter_security_workforce/app/modules/profile_verification_page/presentation/views/step_two_page.dart';
import 'package:get/get.dart';

import '../../data/models/verification_details_model.dart';
import '../views/in_review_message_page.dart';

class ProfileVerificationPageController extends GetxController {
  List<Widget> pages = [
    StepOnePage(),
    StepTwoPage(),
    StepThreePage(),
    StepFourPage(),
    StepFivePage(),
    InReviewMessagePage(),
  ];

  late LoginResponseModel loginResponseModel;
  VerificationDetailsModel verificationDetailsModel =
      VerificationDetailsModel();

  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController summaryTEC = TextEditingController();
  final TextEditingController licenseExpireTEC = TextEditingController();
  final TextEditingController accreditationTEC = TextEditingController();
  final TextEditingController bankNameTEC = TextEditingController();
  final TextEditingController accountHolderNameTEC = TextEditingController();
  final TextEditingController accountNumberTEC = TextEditingController();
  final TextEditingController bsbNumberTEC = TextEditingController();

  File? imageFile;

  int pageIndex = 0;

  double prefRadius = 1.0;

  bool sendNotifications = false;

  bool nextButtonInProgress = false;

  String selectedGender = "";

  String selectedLanguage = "";

  String selectedYearsOfExperience = "";

  String selectedStateOrTerritory = "";

  String selectedLicenseType = "";

  String selectedAccreditation = "";

  void setSelectedAccreditation(String value) {
    selectedAccreditation = value;
    update();
  }

  void setGender(String value) {
    selectedGender = value;
    update();
  }

  void toggleSendNotifications() {
    sendNotifications = !sendNotifications;
    update();
  }

  void setLanguage(String value) {
    selectedLanguage = value;
    update();
  }

  void setStateOrTerritory(String value) {
    selectedStateOrTerritory = value;
    update();
  }

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  void setYearsOfExperience(String value) {
    selectedYearsOfExperience = value;
    update();
  }

  Future<void> increasePageIndex() async {
    pageIndex++;
    update();
  }

  void decreasePageIndex() {
    if (pageIndex > 0) {
      pageIndex--;
    }
    update();
  }

  Future<void> submitFirstStepData({required BuildContext context}) async {
    nextButtonInProgress = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.profileUpdateUrl,
        data: {
          "first_name": fullNameTEC.text.trim(),
          "phone": phoneTEC.text.trim(),
          "gender": selectedGender,
        },
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Updated"),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      }
    } on AppException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      nextButtonInProgress = false;
      update();
      return;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.primaryRed,
          ),
        );
      }

      nextButtonInProgress = false;
      update();
      return;
    }

    nextButtonInProgress = false;
    update();
    increasePageIndex();
  }

  @override
  void onInit() {
    super.onInit();

    fullNameTEC.text =
        Get.arguments["guard_details"]["candidate"]["first_name"] ?? "";
    phoneTEC.text = Get.arguments["guard_details"]["candidate"]["phone"] ?? "";
    selectedGender =
        Get.arguments["guard_details"]["candidate"]["gender"] ?? "";

    selectedLanguage =
        Get.arguments["guard_details"]["candidate"]["language"] ?? "";

    loginResponseModel = LoginResponseModel.fromJson(Get.arguments);

    // print("sajid testing ${loginResponseModel.toJson()}");

    update();
  }

  @override
  void onClose() {
    fullNameTEC.dispose();
    phoneTEC.dispose();
    summaryTEC.dispose();
    licenseExpireTEC.dispose();
    accreditationTEC.dispose();
    bankNameTEC.dispose();
    accountHolderNameTEC.dispose();
    accountNumberTEC.dispose();
    bsbNumberTEC.dispose();
    super.onClose();
  }
}
