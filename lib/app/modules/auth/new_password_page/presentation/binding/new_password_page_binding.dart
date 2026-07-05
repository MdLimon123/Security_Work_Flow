import 'package:securiverse_security_workforce/app/modules/auth/new_password_page/presentation/controllers/new_password_page_controller.dart';
import 'package:get/get.dart';

class NewPasswordPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPasswordPageController());
  }
}
