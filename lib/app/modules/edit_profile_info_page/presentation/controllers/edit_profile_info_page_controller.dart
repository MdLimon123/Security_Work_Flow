import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/data/models/profile_info_model.dart';
import 'package:get/get.dart';

class EditProfileInfoPageController extends GetxController {
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
