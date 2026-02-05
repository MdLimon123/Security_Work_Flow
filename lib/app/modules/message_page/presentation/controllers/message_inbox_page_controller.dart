import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:flutter_security_workforce/app/core/network/socket_api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ChatMessage {
//   final String text;
//   final bool isMe;
//   //final DateTime timestamp;
//   final String? senderId;

//   ChatMessage({
//     required this.text,
//     required this.isMe,
//    // required this.timestamp,
//     this.senderId,
//   });

//   factory ChatMessage.fromJson(
//     Map<String, dynamic> json,
//     String currentUserId,
//   ) {
//     String? senderId;
//     if (json['sender'] != null && json['sender'] is Map) {
//       senderId = json['sender']['id']?.toString();
//     } else if (json['sender_id'] != null) {
//       senderId = json['sender_id']?.toString();
//     }

//     final isMe = senderId == currentUserId;
//     debugPrint(
//       'Message from sender: $senderId, current user: $currentUserId, isMe: $isMe',
//     );

//     return ChatMessage(
//       text: json['message'] ?? json['text'] ?? '',
//       isMe: isMe,
//       // timestamp: json['timestamp'] != null
//       //     ? DateTime.parse(json['timestamp'])
//       //     : json['created_at'] != null
//       //     ? DateTime.parse(json['created_at'])
//       //     : DateTime.now(),
//       senderId: senderId,
//     );
//   }
// }

// class MessageInboxPageController extends GetxController {
//   TextEditingController messageTEC = TextEditingController();
//   ScrollController scrollController = ScrollController();

//   RxList<ChatMessage> messages = <ChatMessage>[].obs;
//   RxBool isConnected = false.obs;
//   RxBool isLoading = true.obs;

//   String currentUserId = "";
//   String conversationId = "";
//   String participantName = "";
//   String participantImage = "";

//   Timer? _reconnectTimer;

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeFromArguments();
//     _initializeController();
//   }

//   void _initializeFromArguments() {
//     if (Get.arguments != null) {
//       conversationId = Get.arguments['conversation_id']?.toString() ?? '';
//       participantName =
//           Get.arguments['participant_name']?.toString() ?? 'Unknown';
//       participantImage = Get.arguments['participant_image']?.toString() ?? '';
//     }
//   }

//   Future<void> _initializeController() async {
//     await _loadCurrentUserId();
//     await _fetchMessageHistory();
//     _initializeWebSocket();
//   }

//   Future<void> _loadCurrentUserId() async {
//     try {
//       DioClient dioClient = DioClient();
//       final response = await dioClient.get(ApiEndpoints.profileInfoUrl);

//       if (response['success'] == true && response['data'] != null) {
//         currentUserId = response['data']['id']?.toString() ?? '';
//         debugPrint('Loaded current user ID: $currentUserId');
//       }
//     } catch (e) {
//       debugPrint('Error loading user ID: $e');
//     }
//   }

//   Future<void> _fetchMessageHistory() async {
//     if (conversationId.isEmpty) {
//       isLoading.value = false;
//       return;
//     }

//     try {
//       DioClient dioClient = DioClient();
//       final response = await dioClient.get(
//         ApiEndpoints.getMessageHistoryUrl(conversationId: conversationId),
//       );

//       if (response['success'] == true && response['data'] != null) {
//         List<dynamic> messageList = response['data'] ?? [];
//         messages.value = messageList
//             .map((msg) => ChatMessage.fromJson(msg, currentUserId))
//             .toList();

//         Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
//       }
//     } catch (e) {
//       debugPrint('Error fetching message history: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void _initializeWebSocket() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString(AppKeys.accessTokenKey) ?? '';

//     if (token.isEmpty) return;

//     try {
//       SocketApi.init(token);

//       SocketApi.messageStream.listen(
//         (data) {
//           _handleIncomingMessage(data);
//         },
//         onError: (error) {
//           debugPrint('SocketApi error: $error');
//           _setDisconnected();
//         },
//         onDone: () {
//           debugPrint('SocketApi closed');
//           _setDisconnected();
//         },
//       );

//       isConnected.value = true;
//     } catch (e) {
//       debugPrint('WebSocket init error: $e');
//       _setDisconnected();
//     }
//   }

//   void _setDisconnected() {
//     isConnected.value = false;

//     _reconnectTimer?.cancel();
//     _reconnectTimer = Timer(Duration(seconds: 3), () {
//       if (!isConnected.value) {
//         debugPrint('Reconnecting SocketApi...');
//         _initializeWebSocket();
//       }
//     });
//   }

//   void _handleIncomingMessage(dynamic data) {
//     try {
//       Map<String, dynamic> jsonData = data is String ? json.decode(data) : data;

//       final msgConversationId = jsonData['chat_id']?.toString() ?? '';
//       if (msgConversationId != conversationId) return;

//       if (jsonData['type'] == 'chat_message' || jsonData['message'] != null) {
//         final message = ChatMessage.fromJson(jsonData, currentUserId);

//         if (!messages.any(
//           (m) =>
//               m.text == message.text &&
//               m.timestamp.difference(message.timestamp).abs().inSeconds < 2,
//         )) {
//           messages.add(message);
//           Future.delayed(Duration(milliseconds: 100), _scrollToBottom);
//         }
//       }
//     } catch (e) {
//       debugPrint('Error parsing incoming message: $e');
//     }
//   }

//   void sendMessage() {
//     if (messageTEC.text.trim().isEmpty || !isConnected.value) {
//       Get.snackbar(
//         'Connection Error',
//         'Not connected to chat server',
//         backgroundColor: AppColors.primaryRed,
//         colorText: AppColors.primaryWhite,
//       );
//       return;
//     }

//     final messageText = messageTEC.text.trim();
//     final messageData = {
//       'message': messageText,
//       'chat_id': int.parse(conversationId),
//     };

//     try {
//       SocketApi.emit(messageData);

//       messages.add(
//         ChatMessage(
//           text: messageText,
//           isMe: true,
//           timestamp: DateTime.now(),
//           senderId: currentUserId,
//         ),
//       );

//       messageTEC.clear();
//       _scrollToBottom();
//     } catch (e) {
//       debugPrint('Error sending message: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to send message',
//         backgroundColor: AppColors.primaryRed,
//         colorText: AppColors.primaryWhite,
//       );
//     }
//   }

//   void _scrollToBottom() {
//     if (scrollController.hasClients) {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   void onClose() {
//     messageTEC.dispose();
//     scrollController.dispose();
//     SocketApi.disconnect();
//     _reconnectTimer?.cancel();
//     super.onClose();
//   }
// }

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime createdAt;
  final String? senderId;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.createdAt,
    this.senderId,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    String? senderId;

    if (json['sender'] != null && json['sender'] is Map) {
      senderId = json['sender']['id']?.toString();
    } else if (json['sender_id'] != null) {
      senderId = json['sender_id']?.toString();
    }

    final bool isMe = senderId == currentUserId;

    return ChatMessage(
      text: json['text'] ?? json['message'] ?? '',
      isMe: isMe,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']).toLocal()
          : DateTime.now(),
      senderId: senderId,
    );
  }
}

class MessageInboxPageController extends GetxController {
  TextEditingController messageTEC = TextEditingController();
  ScrollController scrollController = ScrollController();

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxBool isConnected = false.obs;
  RxBool isLoading = true.obs;

  String currentUserId = "";
  String conversationId = "";
  String participantName = "";
  String participantImage = "";

  Timer? _reconnectTimer;

  @override
  void onInit() {
    super.onInit();
    _initializeFromArguments();
    _initializeController();
  }

  void _initializeFromArguments() {
    if (Get.arguments != null) {
      conversationId = Get.arguments['conversation_id']?.toString() ?? '';
      participantName =
          Get.arguments['participant_name']?.toString() ?? 'Unknown';
      participantImage = Get.arguments['participant_image']?.toString() ?? '';
    }
  }

  Future<void> _initializeController() async {
    await _loadCurrentUserId();
    await _fetchMessageHistory();
    _initializeWebSocket();
  }

  Future<void> _loadCurrentUserId() async {
    try {
      DioClient dioClient = DioClient();
      final response = await dioClient.get(ApiEndpoints.profileInfoUrl);

      if (response['success'] == true && response['data'] != null) {
        currentUserId = response['data']['id']?.toString() ?? '';
      }
    } catch (e) {
      debugPrint('Error loading user ID: $e');
    }
  }

  Future<void> _fetchMessageHistory() async {
    if (conversationId.isEmpty) {
      isLoading.value = false;
      return;
    }

    try {
      DioClient dioClient = DioClient();
      final response = await dioClient.get(
        ApiEndpoints.getMessageHistoryUrl(conversationId: conversationId),
      );

      if (response['success'] == true && response['data'] != null) {
        final List list = response['data'];

        messages.value = list
            .map((e) => ChatMessage.fromJson(e, currentUserId))
            .toList();

        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    } catch (e) {
      debugPrint('Error fetching messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _initializeWebSocket() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(AppKeys.accessTokenKey) ?? '';

    if (token.isEmpty) return;

    try {
      SocketApi.init(token);

      SocketApi.messageStream.listen(
        (data) => _handleIncomingMessage(data),
        onError: (_) => _setDisconnected(),
        onDone: _setDisconnected,
      );

      isConnected.value = true;
    } catch (e) {
      _setDisconnected();
    }
  }

  void _setDisconnected() {
    isConnected.value = false;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (!isConnected.value) {
        _initializeWebSocket();
      }
    });
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final Map<String, dynamic> jsonData = data is String
          ? json.decode(data)
          : data;

      final msgConversationId = jsonData['chat_id']?.toString() ?? '';
      if (msgConversationId != conversationId) return;

      final message = ChatMessage.fromJson(jsonData, currentUserId);

      final alreadyExists = messages.any(
        (m) =>
            m.text == message.text &&
            m.senderId == message.senderId &&
            m.createdAt.difference(message.createdAt).abs().inSeconds < 2,
      );

      if (!alreadyExists) {
        messages.add(message);
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    } catch (e) {
      debugPrint('Incoming message error: $e');
    }
  }

  void sendMessage() {
    if (messageTEC.text.trim().isEmpty || !isConnected.value) return;

    final text = messageTEC.text.trim();

    SocketApi.emit({'message': text, 'chat_id': int.parse(conversationId)});

    messages.add(
      ChatMessage(
        text: text,
        isMe: true,
        createdAt: DateTime.now(),
        senderId: currentUserId,
      ),
    );

    messageTEC.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    messageTEC.dispose();
    scrollController.dispose();
    SocketApi.disconnect();
    _reconnectTimer?.cancel();
    super.onClose();
  }
}
