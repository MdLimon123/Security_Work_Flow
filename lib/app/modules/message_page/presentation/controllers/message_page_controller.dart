import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/message_page/data/model/chatlist_model.dart';
import 'package:get/get.dart';

class MessagePageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();
  final TextEditingController messageTEC = TextEditingController();

  bool msgPageLoading = false;

  ChatlistModel chatlistModel = ChatlistModel();

  Future<void> _fetchChatList() async {
    msgPageLoading = true;
    update();

    try {
      DioClient dioClient = DioClient();

      chatlistModel = ChatlistModel.fromJson(
        await dioClient.get(ApiEndpoints.chatListUrl),
      );
    } on AppException catch (e) {
      Get.snackbar(
        "Error",
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }

    msgPageLoading = false;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await _fetchChatList();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    messageTEC.dispose();
    super.onClose();
  }
}
