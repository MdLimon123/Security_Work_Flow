import 'package:securiverse_security_workforce/app/modules/splash_page/presentation/controller/splash_page_controller.dart';
import 'package:get/get.dart';

class SlpashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController());
  }
}
