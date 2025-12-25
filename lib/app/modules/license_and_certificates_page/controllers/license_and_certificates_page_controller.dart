import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/data/model/licence_list_model.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/data/model/licence_types_model.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class LicenseAndCertificatesPageController extends GetxController {
  String selectedLicenseType = "";
  bool licencesListFetching = false;
  bool addLicenceLoading = false;
  bool submitting = false;
  LicenceListModel licenseListModel = LicenceListModel();
  LicenceTypesModel licenceTypesModel = LicenceTypesModel();

  File? licenceFile;

  final TextEditingController expireDateTEC = TextEditingController();

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  Future<void> pickLicenceFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      licenceFile = File(result.files.single.path!);
      update();
    }
  }

  Future<void> submitLicence() async {
    submitting = true;
    update();

    try {
      DioClient dioClient = DioClient();

      int licenceTypeId = 0;

      for (int i = 0; i < licenceTypesModel.licenceTypes!.length; i++) {
        if (licenceTypesModel.licenceTypes?[i].title == selectedLicenseType) {
          licenceTypeId = i;
          break;
        }
      }

      FormData formData = FormData.fromMap({
        "licence_type": licenceTypeId.toString(),
        "expire_date": expireDateTEC.text,
        "licence_images": await MultipartFile.fromFile(
          licenceFile!.path,
          filename: licenceFile!.uri.pathSegments.last, // Filename
        ),
      });

      await dioClient.post(ApiEndpoints.licenseUrl, data: formData);
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    submitting = false;
    update();
  }

  Future<void> _fetchLicenceTypeList() async {
    licencesListFetching = true;
    update();
    try {
      DioClient dioClient = DioClient();

      licenceTypesModel = LicenceTypesModel.fromJson(
        await dioClient.get(ApiEndpoints.licenceTypeListUrl),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    licencesListFetching = false;
    update();
  }

  Future<void> _fetchLicencesList() async {
    licencesListFetching = true;
    update();

    try {
      DioClient dioClient = DioClient();

      licenseListModel = LicenceListModel.fromJson(
        await dioClient.get(ApiEndpoints.licenseUrl),
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

    licencesListFetching = false;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await _fetchLicencesList();
    await _fetchLicenceTypeList();
  }

  @override
  void onClose() {
    expireDateTEC.dispose();
    super.onClose();
  }
}
