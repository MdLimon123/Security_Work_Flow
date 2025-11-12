import 'package:flutter_security_workforce/app/modules/contact_page/presentation/controllers/contact_page_controller.dart';
import 'package:get/get.dart';

class ContactPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactPageController());
  }
}
