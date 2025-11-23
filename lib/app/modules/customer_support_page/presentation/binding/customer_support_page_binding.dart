import 'package:flutter_security_workforce/app/modules/customer_support_page/presentation/controllers/customer_support_page_controller.dart';
import 'package:get/get.dart';

class CustomerSupportPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerSupportPageController());
  }
}
