import 'package:flutter_security_workforce/app/modules/finish_shift_page/presentation/controllers/finish_shift_page_controller.dart';
import 'package:get/get.dart';

class FinishShiftPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FinishShiftPageController());
  }
}
