import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/controllers/bottom_navbar_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/bindings/home_binding.dart';
import 'package:get/get.dart';

class BottomNavbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavbarPageController());
    Get.lazyPut(() => HomeBinding());
  }
}
