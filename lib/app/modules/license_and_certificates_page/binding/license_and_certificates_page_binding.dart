import 'package:flutter_security_workforce/app/modules/license_and_certificates_page/controllers/license_and_certificates_page_controller.dart';
import 'package:get/get.dart';

class LicenseAndCertificatesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LicenseAndCertificatesPageController());
  }
}
