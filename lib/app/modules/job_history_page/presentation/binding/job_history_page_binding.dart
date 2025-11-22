import 'package:flutter_security_workforce/app/modules/job_history_page/presentation/controllers/job_history_page_controller.dart';
import 'package:get/get.dart';

class JobHistoryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobHistoryPageController());
  }
}
