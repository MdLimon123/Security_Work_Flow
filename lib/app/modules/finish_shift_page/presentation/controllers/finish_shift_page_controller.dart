import 'package:get/get.dart';

class FinishShiftPageController extends GetxController {
  int communicationSelectedIndex = 5;
  int paymentSelectedIndex = 5;
  int payRatesSelectedIndex = 5;
  int professionalismSelectedIndex = 5;
  int jobSupportSelectedIndex = 5;

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
