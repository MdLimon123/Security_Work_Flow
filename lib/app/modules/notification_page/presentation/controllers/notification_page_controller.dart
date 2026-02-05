import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/notification_page/data/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationPageController extends GetxController {
  NotificationModel notificationListModel = NotificationModel();
  bool isNotification = false;

  @override
  onInit() {
    _fetchNotificationList();
    super.onInit();
  }

  Future<void> _fetchNotificationList() async {
    isNotification = true;
    update();

    try{
      DioClient dioClient = DioClient();
      notificationListModel = NotificationModel.fromJson(
        await dioClient.get(ApiEndpoints.notificationListUrl),
      );
    } 
    on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    isNotification = false;
    update();
      
    }
  
}
