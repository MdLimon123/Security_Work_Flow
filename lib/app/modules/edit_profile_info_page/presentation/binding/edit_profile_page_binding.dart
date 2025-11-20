import 'package:flutter_security_workforce/app/modules/edit_profile_info_page/presentation/controllers/edit_profile_info_page_controller.dart';
import 'package:get/get.dart';

class EditProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileInfoPageController());
  }
}
