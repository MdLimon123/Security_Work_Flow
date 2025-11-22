import 'package:flutter_security_workforce/app/modules/other_accreditations_page/presentation/controller/other_accrediations_page_controller.dart';
import 'package:get/get.dart';

class OtherAccrediationsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtherAccrediationsPageController());
  }
}
