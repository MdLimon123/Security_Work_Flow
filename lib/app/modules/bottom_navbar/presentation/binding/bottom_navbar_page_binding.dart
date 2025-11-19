import 'package:flutter_security_workforce/app/modules/bottom_navbar/presentation/controllers/bottom_navbar_page_controller.dart';
import 'package:flutter_security_workforce/app/modules/contact_page/presentation/binding/contact_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/home_page/presentation/bindings/home_binding.dart';
import 'package:flutter_security_workforce/app/modules/message_page/presentation/binding/message_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/my_jobs_page/presentation/binding/my_jobs_page_binding.dart';
import 'package:flutter_security_workforce/app/modules/profile_page/binding/profile_page_binding.dart';
import 'package:get/get.dart';

class BottomNavbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavbarPageController(), fenix: true);
    Get.lazyPut(() => HomeBinding(), fenix: true);
    Get.lazyPut(() => MyJobsPageBinding(), fenix: true);
    Get.lazyPut(() => ContactPageBinding(), fenix: true);
    Get.lazyPut(() => MessagePageBinding(), fenix: true);
    Get.lazyPut(() => ProfilePageBinding(), fenix: true);
  }
}
