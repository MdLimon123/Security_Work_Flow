import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/job_history_page/models/job_history_list_model.dart';
import 'package:get/get.dart';

class JobHistoryPageController extends GetxController {
  
  bool pageLoading = false;

  JobHistoryListModel jobHistoryListModel = JobHistoryListModel();

  Future<void> fetchJobHistory() async {
    pageLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      jobHistoryListModel = JobHistoryListModel.fromJson(
        await dioClient.get(ApiEndpoints.jobHistoryUrl),
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
    await fetchJobHistory();
  }
}
