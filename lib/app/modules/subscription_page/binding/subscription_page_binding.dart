import 'package:flutter_security_workforce/app/modules/subscription_page/controllers/subscription_page_controller.dart';
import 'package:get/get.dart';

class SubscriptionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscriptionPageController(), fenix: true);
  }
}
