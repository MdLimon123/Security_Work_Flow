import 'package:securiverse_security_workforce/app/modules/auth/forget_pass_page/presentation/controllers/verify_forget_pass_otp_page_controller.dart';
import 'package:get/get.dart';

class VerifyForgetPassOtpPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyForgetPassOtpPageController());
  }
}
