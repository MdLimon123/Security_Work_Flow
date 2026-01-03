import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/modules/message_page/data/model/chatlist_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagePageController extends GetxController {
  final TextEditingController searchTEC = TextEditingController();
  final TextEditingController messageTEC = TextEditingController();

  bool msgPageLoading = false;

  ChatlistModel chatlistModel = ChatlistModel();
  late WebSocketChannel channel;

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

  Future<void> _connectWebSocket() async {
    try {
      final wsUrl = await getWebSocketLink();
      channel = IOWebSocketChannel.connect(Uri.parse(wsUrl));

      channel.stream.listen(
        (message) {
          debugPrint('Received from socket: $message');
          // For now, we just refetch the chat list to update the view.
          _fetchChatList();
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
        },
        onError: (error) {
          debugPrint('WebSocket error: $error');
        },
      );
    } catch (e) {
      debugPrint("Error connecting to WebSocket: $e");
    }
  }

  void sendMessage() {
    if (messageTEC.text.isNotEmpty) {
      final messageObject = {
        'message': messageTEC.text,
      };
      channel.sink.add(jsonEncode(messageObject));
      messageTEC.clear();
    }
  }

  Future<String> getWebSocketLink() async {
    // Get token from your auth storage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppKeys.accessTokenKey) ?? '';

    // Your WebSocket base URL
    // IMPORTANT: '10.10.12.15' is a private IP. This will only work if your
    // phone and server are on the same WiFi network.
    const wsBaseUrl = 'ws://10.10.12.15:8001/ws/asc/update_chat_messages/';

    return '$wsBaseUrl?token=$token';
  }

  // Alternative: If you store token elsewhere, adjust accordingly
  Future<String> getWebSocketLinkWithToken(String token) async {
    const wsBaseUrl = 'ws://10.10.12.15:8001/ws/asc/update_chat_messages/';
    return '$wsBaseUrl?token=$token';
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await _fetchChatList();
    await _connectWebSocket();
  }

  @override
  void onClose() {
    searchTEC.dispose();
    messageTEC.dispose();
    channel.sink.close();
    super.onClose();
  }
}
