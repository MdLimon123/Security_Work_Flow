import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/home_page/data/models/open_job_list_model.dart';
import 'package:flutter_security_workforce/app/modules/search_page/data/model/accreditation_model.dart';
import 'package:flutter_security_workforce/app/modules/search_page/data/model/license_model.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();

  bool isLoading = false;

  OpenJobListModel openJobListModel = OpenJobListModel();
      double radius = 60;

  LicenseResponseModel licenseResponseModel = LicenseResponseModel();
  AccreditationResponseModel accreditationResponseModel = AccreditationResponseModel();

  int selectedLicense = -1;
  int selectedAccreditation = -1;
  Timer? _debounce;

  List<int> payRange = [16, 32];

   void updateRadius(double value) {
    radius = value;
    update();
  }

  void setSelectedAccreditation({required int index}) {
    if (index == selectedAccreditation) {
      selectedAccreditation = -1;
    } else {
      selectedAccreditation = index;
    }
    update();
  }

  @override
  void onInit() {
    searchTEC.addListener(() {
      final query = searchTEC.text.trim();

      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        loadOpenJobs(searchQuery: query);
      });
    });

    fetchLicense();
    fetchAccreditation();

    super.onInit();
  }

  void setSelectedLicense({required int index}) {
    if (index == selectedLicense) {
      selectedLicense = -1;
    } else {
      selectedLicense = index;
    }
    update();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    super.onClose();
  }


  Future<void> fetchAccreditation() async {
    try {
      DioClient dioClient = DioClient();
      accreditationResponseModel = AccreditationResponseModel.fromJson(
        await dioClient.get(ApiEndpoints.accreditationUploadUrr),
      );
      update();
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

  Future<void> fetchLicense() async {
    try {
      DioClient dioClient = DioClient();
      licenseResponseModel = LicenseResponseModel.fromJson(
        await dioClient.get(ApiEndpoints.licenseUploadUrr),
      );
      update();
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

  // Future<void> loadOpenJobs({String? searchQuery}) async {
  //   isLoading = true;
  //   update();
  //   try {
  //     DioClient dioClient = DioClient();

  //     final url = searchQuery != null && searchQuery.isNotEmpty
  //         ? "${ApiEndpoints.jobListUrl}?title=$searchQuery"
  //         : ApiEndpoints.jobListUrl;

  //     final response = await dioClient.get(url);

  //     openJobListModel = OpenJobListModel.fromJson(response);

  //     update();
  //   } on AppException catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.message,
  //       backgroundColor: AppColors.primaryRed,
  //       colorText: AppColors.primaryWhite,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //       backgroundColor: AppColors.primaryRed,
  //       colorText: AppColors.primaryWhite,
  //     );
  //   }

  //   isLoading = false;
  //   update();
  // }


  Future<void> loadOpenJobs({String? searchQuery}) async {
  isLoading = true;
  update();

  try {
    DioClient dioClient = DioClient();

 
    Map<String, dynamic> queryParams = {};


    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams["title"] = searchQuery;
    }

    queryParams["radius"] = radius.toInt();


    if (selectedLicense != -1) {
      queryParams["ln_type_id"] = selectedLicense;
    }


    if (selectedAccreditation != -1) {
      queryParams["acc_type_id"] = selectedAccreditation;
    }


    queryParams["pay_rate_min"] = payRange.first;
    queryParams["pay_rate_max"] = payRange.last;


    final response = await dioClient.get(
      ApiEndpoints.jobListUrl,
      queryParams: queryParams,
    );

    openJobListModel = OpenJobListModel.fromJson(response);

    update();
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

  isLoading = false;
  update();
}

}
