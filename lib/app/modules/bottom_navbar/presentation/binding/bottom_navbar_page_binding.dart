import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/controllers/bottom_navbar_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/presentation/controllers/contact_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/controllers/message_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/controllers/my_jobs_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

class BottomNavbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavbarPageController(), fenix: true);
    Get.lazyPut(() => HomePageController(), fenix: true);
    Get.lazyPut(() => MyJobsPageController(), fenix: true);
    Get.lazyPut(() => ContactPageController(), fenix: true);
    Get.lazyPut(() => MessagePageController(), fenix: true);
    Get.lazyPut(() => ProfilePageController(), fenix: true);
  }
}
