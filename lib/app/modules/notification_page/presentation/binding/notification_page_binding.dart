import 'package:flutter_security_workforce/app/modules/notification_page/presentation/controllers/notification_page_controller.dart';
import 'package:get/get.dart';

class NotificationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationPageController());
  }
}
