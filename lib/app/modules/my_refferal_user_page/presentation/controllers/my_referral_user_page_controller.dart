import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/my_refferal_user_page/presentation/data/models/my_refer_list_model.dart';
import 'package:get/get.dart';

class MyReferralUserPageController extends GetxController {
  bool pageLoading = false;

  MyReferListModel myReferListModel = MyReferListModel();

  Future<void> _fetchReferList() async {
    pageLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();
      myReferListModel = MyReferListModel.fromJson(
        await dioClient.get(ApiEndpoints.referalListUrl),
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
    await _fetchReferList();
  }
}
