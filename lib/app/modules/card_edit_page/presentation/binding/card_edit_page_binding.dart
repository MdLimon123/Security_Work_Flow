import 'package:flutter_security_workforce/app/modules/card_edit_page/presentation/controllers/card_edit_page_controller.dart';
import 'package:get/get.dart';

class CardEditPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CardEditPageController());
  }
}
