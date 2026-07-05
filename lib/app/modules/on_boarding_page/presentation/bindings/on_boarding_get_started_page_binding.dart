import 'package:securiverse_security_workforce/app/modules/on_boarding_page/presentation/controllers/on_boarding_get_started_page_controller.dart';
import 'package:get/get.dart';

class OnBoardingGetStartedPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingGetStartedPageController(), fenix: true);
  }
}
