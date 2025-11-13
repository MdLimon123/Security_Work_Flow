import 'package:flutter_security_workforce/app/modules/open_contact_page/presentation/controllers/open_contact_page_controller.dart';
import 'package:get/get.dart';

class OpenContactPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OpenContactPageController());
  }
}
