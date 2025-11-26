import 'package:get/get.dart';

import '../controllers/verify_registration_otp_page_controller.dart';

class VerifyRegistrationOtpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyRegistrationOtpPageController(), fenix: true);
  }
}
