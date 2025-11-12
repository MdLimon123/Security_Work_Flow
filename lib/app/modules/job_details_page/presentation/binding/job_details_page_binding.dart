import 'package:flutter_security_workforce/app/modules/job_details_page/presentation/controllers/job_details_page_controller.dart';
import 'package:get/get.dart';

class JobDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobDetailsPageController());
  }
}
