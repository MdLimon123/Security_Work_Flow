import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  bool notificationOn = false;

  void toggleNotification() {
    notificationOn = !notificationOn;
    update();
  }
}
