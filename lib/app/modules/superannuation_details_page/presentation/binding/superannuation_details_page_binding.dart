import 'package:flutter_security_workforce/app/modules/superannuation_details_page/presentation/controllers/superannuation_details_page_controller.dart';
import 'package:get/get.dart';

class SuperannuationDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SuperannuationDetailsPageController());
  }
}
