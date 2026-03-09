import 'dart:developer';
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

  List<File> licenceFiles = [];
  DateTime? selectedExpireDate;

  final TextEditingController expireDateTEC = TextEditingController();

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
    update();
  }

  Future<void> pickLicenceFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result != null) {
      licenceFiles.addAll(
        result.files.map((file) => File(file.path!)),
      );
      update();
    }
  }

  void removeLicenceFile(int index) {
    licenceFiles.removeAt(index);
    update();
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

      // log(
      //   "sajid testing ${licenceTypesModel.licenceTypes?[licenceTypeId].id.toString()}",
      // );

      final formData = FormData();

      final backendDate = selectedExpireDate != null
          ? "${selectedExpireDate!.year}-${selectedExpireDate!.month.toString().padLeft(2, '0')}-${selectedExpireDate!.day.toString().padLeft(2, '0')}"
          : "";
      formData.fields.add(
        MapEntry("0.expire_date", backendDate),
      );

      formData.fields.add(
        MapEntry("0.licence_types", licenceTypesModel.licenceTypes![licenceTypeId].id.toString()),
      );

      for (var file in licenceFiles) {
        formData.files.add(
          MapEntry(
            "0.licence_images",
            await MultipartFile.fromFile(
              file.path,
              filename: file.uri.pathSegments.last,
            ),
          ),
        );
      }

      await dioClient.post(ApiEndpoints.addLicenceUrl, data: formData);
      await _fetchLicencesList();
      await _fetchLicenceTypeList();

      submitting = false;
      update();

      Get.back();
      Get.snackbar(
        "Success",
        "Licence added successfully!",
        backgroundColor: AppColors.primaryGreen,
        colorText: AppColors.primaryWhite,
      );
      return;
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );

      log(e.message);
    }

    submitting = false;
    update();
  }

  Future<void> deleteLicence({required int id}) async {
    try {
      DioClient dioClient = DioClient();
      log("Deleting licence with URL: ${ApiEndpoints.deleteLicenceUrl(id: id.toString())}");
      await dioClient.delete(ApiEndpoints.deleteLicenceUrl(id: id.toString()));
      await _fetchLicencesList();
      Get.snackbar(
        "Success",
        "Licence deleted successfully!",
        backgroundColor: AppColors.primaryGreen,
        colorText: AppColors.primaryWhite,
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
  }

  Future<void> _fetchLicenceTypeList() async {
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
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    update();
  }

  Future<void> _fetchLicencesList() async {
    licencesListFetching = true;
    update();

    try {
      DioClient dioClient = DioClient();

      final response = await dioClient.get(ApiEndpoints.licenseUrl);
      log("Licence list API response: $response");
      licenseListModel = LicenceListModel.fromJson(response);
      log("Parsed licence list data count: ${licenseListModel.data?.length}");
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
