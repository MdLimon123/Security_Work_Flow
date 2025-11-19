import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_page_controller.dart';
import 'package:get/get.dart';

class MessagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessagePageController(), fenix: true);
  }
}
