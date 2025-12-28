import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/other_accreditations_page/data/model/certificate_list_model.dart';
import 'package:flutter_security_workforce/app/modules/other_accreditations_page/data/model/certificate_type_list_model.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class OtherAccrediationsPageController extends GetxController {
  bool fullPageLoading = false;

  String selectedLicenseType = "";

  bool submitting = false;

  File? certificateFile;

  final TextEditingController expireDateTEC = TextEditingController();

  CertificateTypeListModel certificateTypeListModel =
      CertificateTypeListModel();

  CertificateListModel certificateListModel = CertificateListModel();

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      certificateFile = File(result.files.single.path!);
      update();
    }
  }

  Future<void> _fetchAccreditationList() async {
    DioClient dioClient = DioClient();
    try {
      final response = await dioClient.get(ApiEndpoints.accreditationUrl);

      certificateListModel = CertificateListModel.fromJson(response);

      update();
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }
  }

  Future<void> _fetchAccreditationTypes() async {
    DioClient dioClient = DioClient();
    try {
      final response = await dioClient.get(ApiEndpoints.certificateTypeUrl);
      certificateTypeListModel = CertificateTypeListModel.fromJson(response);
      update();
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }
  }

  Future<void> submitCertificate() async {
    submitting = true;
    update();

    try {
      DioClient dioClient = DioClient();

      String id = "";

      for (
        int i = 0;
        i < (certificateTypeListModel.certificateTypes?.length ?? 0);
        i++
      ) {
        if (selectedLicenseType ==
            certificateTypeListModel.certificateTypes![i].title) {
          id = certificateTypeListModel.certificateTypes![i].id.toString();
          break;
        }
      }

      FormData formData = FormData.fromMap({
        "accreditation_type": id,
        "accreditation": await MultipartFile.fromFile(
          certificateFile!.path,
          filename: certificateFile!.uri.pathSegments.last,
        ),
        "expire_date": expireDateTEC.text,
      });

      await dioClient.post(ApiEndpoints.accreditationUrl, data: formData);

      await _fetchAccreditationList();
    } on AppException catch (e) {
      log(e.message);
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

  @override
  Future<void> onInit() async {
    super.onInit();
    fullPageLoading = true;
    update();

    await _fetchAccreditationTypes();
    await _fetchAccreditationList();

    fullPageLoading = false;
    update();
  }

  @override
  void onClose() {
    expireDateTEC.dispose();
    super.onClose();
  }
}
