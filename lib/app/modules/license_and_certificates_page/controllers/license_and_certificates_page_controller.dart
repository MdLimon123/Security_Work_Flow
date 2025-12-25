import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/data/model/licence_list_model.dart';
import 'package:get/get.dart';

class LicenseAndCertificatesPageController extends GetxController {
  String selectedLicenseType = "";
  bool licencesListFetching = false;
  LicenceListModel licenseListModel = LicenceListModel();

  final TextEditingController expireDateTEC = TextEditingController();

  void setSelectedLicenseType(String value) {
    selectedLicenseType = value;
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
  }

  @override
  void onClose() {
    expireDateTEC.dispose();
    super.onClose();
  }
}
