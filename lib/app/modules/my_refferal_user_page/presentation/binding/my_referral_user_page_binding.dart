import 'package:flutter_security_workforce/app/modules/my_refferal_user_page/presentation/controllers/my_referral_user_page_controller.dart';
import 'package:get/get.dart';

class MyReferralUserPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyReferralUserPageController());
  }
}
