import 'package:get/get.dart';

class FinishShiftPageController extends GetxController {
  int communicationSelectedIndex = 1;
  int paymentSelectedIndex = 1;
  int payRatesSelectedIndex = 1;
  int professionalismSelectedIndex = 1;
  int jobSupportSelectedIndex = 1;

  void updateCommunicationSelectedIndex({required int value}) {
    communicationSelectedIndex = value;
    update();
  }

  void updatePaymentSelectedIndex({required int value}) {
    paymentSelectedIndex = value;
    update();
  }

  void updatePayRatesSelectedIndex({required int value}) {
    payRatesSelectedIndex = value;
    update();
  }

  void updateProfessionalismSelectedIndex({required int value}) {
    professionalismSelectedIndex = value;
    update();
  }

  void updateJobSupportSelectedIndex({required int value}) {
    jobSupportSelectedIndex = value;
    update();
  }
}
