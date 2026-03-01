import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/amend_contract_model.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/data/engagement_list_model.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class ContactPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  var isLoading = false;

  var isCheck = false.obs;

  var uploadSignatureLoading = false.obs;
  var isAcceptLoading = false.obs;

  var isRejectLoading = false.obs;

  EngagementListModel engagementListModel = EngagementListModel();

  AmendContractModel amendContractModel = AmendContractModel();

  int selectedIndex = 0;

  void updateIndex(int value) {
    selectedIndex = value;

    update();
    if (selectedIndex == 0) {
      fetchContactList();
    } else {
      fetchAmendContract();
    }
  }

  @override
  void onInit() {
    fetchContactList();

    super.onInit();
  }

  @override
  void onClose() {
    searchTEC.dispose();

    super.onClose();
  }

  Future<void> fetchAmendContract() async {
    isLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      amendContractModel = AmendContractModel.fromJson(
        await dioClient.get(ApiEndpoints.amendContractUrl),
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
    isLoading = false;
    update();
  }

  Future<void> fetchContactList() async {
    isLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      engagementListModel = EngagementListModel.fromJson(
        await dioClient.get(ApiEndpoints.engagementListUrl),
      );

      print("engagementListModel========> $engagementListModel");
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
    isLoading = false;
    update();
  }

  Future<void> rejectContract({required String id}) async {
    isRejectLoading.value = true;

    update();

    try {
      DioClient dioClient = DioClient();
      await dioClient.put(
        ApiEndpoints.acceptJobUrl(id: id),
        data: {"rejected": true},
      );

      Get.snackbar(
        "Success",
        "Contract rejected successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isRejectLoading.value = false;
    update();
  }

  Future<void> acceptContract({required String id}) async {
    isAcceptLoading.value = true;
    update();
    try {
      DioClient dioClient = DioClient();
      await dioClient.put(
        ApiEndpoints.acceptJobUrl(id: id),
        data: {"accept": true},
      );

      Get.snackbar(
        "Success",
        "Contract accepted successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isAcceptLoading.value = false;
    update();
  }

  Future<void> submitSignature({required String id, required File file}) async {
    uploadSignatureLoading.value = true;
    update();
    try {
      DioClient dioClient = DioClient();

      FormData formData = FormData.fromMap({
        'signature_party_b': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      await dioClient.put(
        ApiEndpoints.uploadSignatureUrl(id: id),
        data: formData,
      );

      Get.back(); // close dialog
      Get.back(); // close OpenContactPage

      Get.snackbar(
        "Success",
        "Signature uploaded successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      fetchContactList();
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    uploadSignatureLoading.value = false;
    update();
  }


}
