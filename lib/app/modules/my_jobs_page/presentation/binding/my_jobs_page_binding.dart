import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/controllers/my_jobs_page_controller.dart';
import 'package:get/get.dart';

class MyJobsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyJobsPageController(), fenix: true);
   
  }
}
