import 'package:flutter_security_workforce/app/modules/refer_and_benefits_page/controllers/refer_and_benefits_page_controller.dart';
import 'package:get/get.dart';

class ReferAndBenefitsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReferAndBenefitsPageController(), fenix: true);
  }
}
