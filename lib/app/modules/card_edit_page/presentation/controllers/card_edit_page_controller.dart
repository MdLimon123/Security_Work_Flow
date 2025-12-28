import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';

class CardEditPageController extends GetxController {
  final TextEditingController cardHolderNameTEC = TextEditingController();
  final TextEditingController cardNumberTEC = TextEditingController();
  final TextEditingController expireDateTEC = TextEditingController();
  final TextEditingController cvvTEC = TextEditingController();
  final TextEditingController billingAddressTEC = TextEditingController();

  bool submitting = false;

  Future<void> updateCardDetails() async {
    submitting = true;
    update();

    try {
      DioClient dioClient = DioClient();

      await dioClient.put(
        ApiEndpoints.cardUrl,
        data: {
          "card_holder": cardHolderNameTEC.text,
          "card_number": cardNumberTEC.text,
          "expire_date": expireDateTEC.text,
          "cvc": cvvTEC.text,
          "billing_address": billingAddressTEC.text,
        },
      );


    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    submitting = false;
    update();
  }

  @override
  void onClose() {
    cardHolderNameTEC.dispose();
    cardNumberTEC.dispose();
    expireDateTEC.dispose();
    cvvTEC.dispose();
    billingAddressTEC.dispose();
    super.onClose();
  }
}
