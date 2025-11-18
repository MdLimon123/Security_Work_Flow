import 'package:flutter_security_workforce/app/modules/open_jobs_details_page/presentation/controllers/open_jobs_details_page_controller.dart';
import 'package:get/get.dart';

class OpenJobsDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OpenJobsDetailsPageController(), fenix: true);
  }
}
