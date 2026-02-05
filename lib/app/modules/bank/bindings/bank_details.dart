import 'package:flutter_security_workforce/app/modules/bank/controller/bank_details_controller.dart';
import 'package:get/get.dart';

class BankDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankDetailsController());
  }
}
