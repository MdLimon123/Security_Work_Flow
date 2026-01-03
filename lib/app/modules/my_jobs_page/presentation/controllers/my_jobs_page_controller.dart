import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/data/model/my_job_list_model.dart';
import 'package:get/get.dart';

class MyJobsPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  bool pageLoading = false;

  MyJobListModel myJobListModel = MyJobListModel();

  Future<void> _fetchMyJobList() async {
    pageLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      myJobListModel = MyJobListModel.fromJson(
        await dioClient.get(ApiEndpoints.myJobListUrl),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    pageLoading = false;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await _fetchMyJobList();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
