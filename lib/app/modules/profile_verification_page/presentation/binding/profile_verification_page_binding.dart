import 'package:securiverse_security_workforce/app/modules/profile_verification_page/presentation/controllers/profile_verification_page_controller.dart';
import 'package:get/get.dart';

class ProfileVerificationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileVerificationPageController());
  }
}
