import 'package:flutter_security_workforce/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageController(), fenix: true);
  }
}
