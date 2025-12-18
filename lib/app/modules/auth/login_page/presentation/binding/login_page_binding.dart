import 'package:flutter_security_workforce/app/modules/auth/login_page/presentation/controllers/login_page_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController(),fenix: true);
  }
}
