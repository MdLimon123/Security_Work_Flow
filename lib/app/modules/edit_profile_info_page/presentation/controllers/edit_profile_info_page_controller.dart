import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/data/models/profile_info_model.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

class EditProfileInfoPageController extends GetxController {
  bool saveAndUpdateButtonLoading = false;

  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneNumTEC = TextEditingController();
  final TextEditingController addressTEC = TextEditingController();

  String selectedLanguage = "";
  String selectedGender = "";

  double preferredJobRadius = 1.0;

  bool sendNotifications = false;

  ProfileInfoModel profileInfoModel = ProfileInfoModel();

  File? selectedImageFile;
  String? currentImageUrl;

  void setLanguage(String value) {
    selectedLanguage = value;
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

  Future<void> updateProfileInfo() async {
    saveAndUpdateButtonLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      FormData formData = FormData.fromMap({
        'account_holder_name': fullNameTEC.text,
        'phone': phoneNumTEC.text,
        'address': addressTEC.text,
        'language': selectedLanguage,
        'gender': selectedGender,
        'user_redus': preferredJobRadius.toString(),
        // 'sendNotifications': sendNotifications.toString(),
        if (selectedImageFile != null)
          'image': await MultipartFile.fromFile(
            selectedImageFile!.path,
            filename: selectedImageFile!.path.split('/').last,
          ),
      });

      await dioClient.put(ApiEndpoints.profileUpdateUrl, data: formData);

      await Get.find<ProfilePageController>().fetchProfileInfo();
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

    saveAndUpdateButtonLoading = false;
    update();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      selectedImageFile = File(result.files.single.path!);
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();

    profileInfoModel = ProfileInfoModel.fromJson(Get.arguments);

    currentImageUrl =
        "${ApiEndpoints.getBaseUrl}${profileInfoModel.data?.image}";

    fullNameTEC.text = profileInfoModel.data?.accountHolderName ?? "";
    phoneNumTEC.text = profileInfoModel.data?.phone ?? "";
    addressTEC.text = profileInfoModel.data?.address ?? "";
    selectedLanguage = profileInfoModel.data?.language ?? "English";
    selectedGender = profileInfoModel.data?.gender ?? "";
    preferredJobRadius = profileInfoModel.data?.userRedus?.toDouble() ?? 0.0;

    update();
  }

  @override
  void onClose() {
    fullNameTEC.dispose();
    phoneNumTEC.dispose();
    addressTEC.dispose();
    super.onClose();
  }
}
