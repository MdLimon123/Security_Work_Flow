import 'package:flutter_security_workforce/app/modules/wages_to_be_paid_page/presentation/controllers/wages_to_be_paid_page_controller.dart';
import 'package:get/get.dart';

class WagesToBePaidPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WagesToBePaidPageController());
  }
}
