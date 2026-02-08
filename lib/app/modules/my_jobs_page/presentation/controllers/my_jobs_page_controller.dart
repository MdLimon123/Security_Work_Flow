import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/data/models/job_details_model.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/data/model/my_job_list_model.dart';
import 'package:flutter_security_workforce/app/routes/app_routes.dart';
import 'package:get/get.dart';

class MyJobsPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  bool pageLoading = false;

  Map<String, bool> jobLoading = {};

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

  Future<void> startJob({required String jobId}) async {
    jobLoading[jobId] = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.startJob(id: jobId),
        data: {"start_shift": true},
      );

      Get.snackbar(
        "Success",
        "Shift started successfully",
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
    }

    jobLoading[jobId] = false;
    update();
  }

  Future<void> endJob({required String jobId}) async {
    jobLoading[jobId] = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.endJobUrl(id: jobId),
        data: {"end_shift": true},
      );
      Get.toNamed(
        AppRoutes.finishShiftRoute,
        arguments: JobDetailsModel.fromJson(
          myJobListModel.results?.myJobs?[0].toJson(),
        ),
      );
      Get.snackbar(
        "Success",
        "Shift ended successfully",
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
    }

    jobLoading[jobId] = false;
    update();
  }

  Map<String, bool> jobStatus = {};

  @override
  Future<void> onInit() async {
    super.onInit();

    await _fetchMyJobList();

    myJobListModel.results?.myJobs?.forEach((job) {
      final id = job.id.toString();
      jobLoading[id] = false;
    });
  }

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }
}
