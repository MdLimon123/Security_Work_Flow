import 'package:flutter_security_workforce/app/modules/search_page/controllers/search_page_controller.dart';
import 'package:get/get.dart';

class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
  }
}
