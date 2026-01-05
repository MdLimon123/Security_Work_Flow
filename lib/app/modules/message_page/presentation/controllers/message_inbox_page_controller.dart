import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_security_workforce/app/core/constants/app_colors.dart';
import 'package:flutter_security_workforce/app/core/constants/app_keys.dart';
import 'package:flutter_security_workforce/app/core/errors/app_exceptions.dart';
import 'package:flutter_security_workforce/app/core/network/api_endpoints.dart';
import 'package:flutter_security_workforce/app/core/network/dio_client.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String? senderId;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.senderId,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    // Handle sender information - could be an object or just an ID
    String? senderId;
    if (json['sender'] != null && json['sender'] is Map) {
      senderId = json['sender']['id']?.toString();
    } else if (json['sender_id'] != null) {
      senderId = json['sender_id']?.toString();
    }

    final isMe = senderId == currentUserId;
    debugPrint(
      'Message from sender: $senderId, current user: $currentUserId, isMe: $isMe',
    );

    return ChatMessage(
      text: json['message'] ?? json['text'] ?? '',
      isMe: isMe,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      senderId: senderId,
    );
  }
}

class MessageInboxPageController extends GetxController {
  TextEditingController messageTEC = TextEditingController();
  ScrollController scrollController = ScrollController();

  WebSocketChannel? socketChannel;
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  RxBool isConnected = false.obs;
  RxBool isLoading = true.obs;

  String currentUserId = "";
  String conversationId = "";
  String participantName = "";
  String participantImage = "";

  @override
  void onInit() {
    super.onInit();
    _initializeFromArguments();
    _initializeController();
  }

  Future<void> _initializeController() async {
    await _loadCurrentUserId();
    await _fetchMessageHistory();
    _initializeWebSocket();
  }

  void _initializeFromArguments() {
    if (Get.arguments != null) {
      conversationId = Get.arguments['conversation_id']?.toString() ?? '';
      participantName =
          Get.arguments['participant_name']?.toString() ?? 'Unknown';
      participantImage = Get.arguments['participant_image']?.toString() ?? '';
    }
  }

  Future<void> _loadCurrentUserId() async {
    try {
      DioClient dioClient = DioClient();
      final response = await dioClient.get(ApiEndpoints.profileInfoUrl);

      if (response['success'] == true && response['data'] != null) {
        currentUserId = response['data']['id']?.toString() ?? '';
        debugPrint('Loaded current user ID from profile: $currentUserId');
      } else {
        debugPrint('Failed to load user profile');
      }
    } on AppException catch (e) {
      debugPrint('Error loading user profile: ${e.message}');
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
        List<dynamic> messageList = response['data'] ?? [];
        messages.value = messageList
            .map((msg) => ChatMessage.fromJson(msg, currentUserId))
            .toList()
            .reversed // Reverse to show oldest first, newest last
            .toList();

        Future.delayed(Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    } on AppException catch (e) {
      Get.snackbar(
        'Error',
        e.message,
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    } catch (e) {
      debugPrint('Error fetching message history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _initializeWebSocket() async {
    if (conversationId.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppKeys.accessTokenKey) ?? '';

      final wsUrl = ApiEndpoints.chatSocketUrl(token: token);

      socketChannel = IOWebSocketChannel.connect(Uri.parse(wsUrl));
      isConnected.value = true;

      // Listen to incoming messages
      socketChannel!.stream.listen(
        (data) {
          _handleIncomingMessage(data);
        },
        onError: (error) {
          debugPrint('WebSocket Error: $error');
          isConnected.value = false;
          _attemptReconnection();
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
          isConnected.value = false;
          _attemptReconnection();
        },
      );
    } catch (e) {
      debugPrint('Error initializing WebSocket: $e');
      isConnected.value = false;
      _attemptReconnection();
    }
  }

  void _attemptReconnection() {
    Future.delayed(Duration(seconds: 3), () {
      if (!isConnected.value && conversationId.isNotEmpty) {
        debugPrint('Attempting to reconnect WebSocket...');
        _initializeWebSocket();
      }
    });
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      Map<String, dynamic> jsonData;

      if (data is String) {
        jsonData = json.decode(data);
      } else {
        jsonData = data as Map<String, dynamic>;
      }

      // Handle different message types
      if (jsonData['type'] == 'chat_message' || jsonData['message'] != null) {
        final message = ChatMessage.fromJson(jsonData, currentUserId);

        // Only add if not already in the list (avoid duplicates)
        if (!messages.any(
          (m) =>
              m.text == message.text &&
              m.timestamp.difference(message.timestamp).abs().inSeconds < 2,
        )) {
          messages.add(message);

          Future.delayed(Duration(milliseconds: 100), () {
            _scrollToBottom();
          });
        }
      } else if (jsonData['type'] == 'message_history') {
        List<dynamic> messageList = jsonData['messages'] ?? [];
        messages.value = messageList
            .map((msg) => ChatMessage.fromJson(msg, currentUserId))
            .toList();

        Future.delayed(Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    } catch (e) {
      debugPrint('Error parsing message: $e');
    }
  }

  void sendMessage() {
    if (messageTEC.text.trim().isEmpty ||
        socketChannel == null ||
        !isConnected.value) {
      if (!isConnected.value) {
        Get.snackbar(
          'Connection Error',
          'Not connected to chat server',
          backgroundColor: AppColors.primaryRed,
          colorText: AppColors.primaryWhite,
        );
      }
      return;
    }

    final messageText = messageTEC.text.trim();

    final messageData = json.encode({
      'message': messageText,
      'chat_id': int.parse(conversationId),
    });

    try {
      socketChannel!.sink.add(messageData);

      // Add to local messages immediately for better UX
      messages.add(
        ChatMessage(
          text: messageText,
          isMe: true,
          timestamp: DateTime.now(),
          senderId: currentUserId,
        ),
      );

      messageTEC.clear();
      _scrollToBottom();
    } catch (e) {
      debugPrint('Error sending message: $e');
      Get.snackbar(
        'Error',
        'Failed to send message',
        backgroundColor: AppColors.primaryRed,
        colorText: AppColors.primaryWhite,
      );
    }
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    messageTEC.dispose();
    scrollController.dispose();
    socketChannel?.sink.close();
    super.onClose();
  }
}
