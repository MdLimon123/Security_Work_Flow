import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  factory ChatMessage.fromJson(Map<String, dynamic> json, String currentUserId) {
    return ChatMessage(
      text: json['message'] ?? json['text'] ?? '',
      isMe: json['sender_id']?.toString() == currentUserId,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      senderId: json['sender_id']?.toString(),
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

  String currentUserId = "6"; // Get this from your auth system

  @override
  void onInit() {
    super.onInit();
    // Get socket channel from arguments
    if (Get.arguments != null && Get.arguments['socket_channel'] != null) {
      socketChannel = Get.arguments['socket_channel'];
      _initializeWebSocket();
    }
  }

  void _initializeWebSocket() {
    if (socketChannel == null) return;

    isConnected.value = true;
    isLoading.value = false;

    // Listen to incoming messages
    socketChannel!.stream.listen(
          (data) {
        _handleIncomingMessage(data);
      },
      onError: (error) {
        print('WebSocket Error: $error');
        isConnected.value = false;
      },
      onDone: () {
        print('WebSocket connection closed');
        isConnected.value = false;
      },
    );
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      // Parse the incoming message
      Map<String, dynamic> jsonData;

      if (data is String) {
        jsonData = json.decode(data);
      } else {
        jsonData = data as Map<String, dynamic>;
      }

      // Handle different message types
      if (jsonData['type'] == 'chat_message' || jsonData['message'] != null) {
        final message = ChatMessage.fromJson(jsonData, currentUserId);
        messages.add(message);

        // Scroll to bottom after new message
        Future.delayed(Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      } else if (jsonData['type'] == 'message_history') {
        // Handle initial message history
        List<dynamic> messageList = jsonData['messages'] ?? [];
        messages.value = messageList
            .map((msg) => ChatMessage.fromJson(msg, currentUserId))
            .toList();

        Future.delayed(Duration(milliseconds: 100), () {
          _scrollToBottom();
        });
      }
    } catch (e) {
      print('Error parsing message: $e');
    }
  }

  void sendMessage() {
    if (messageTEC.text.trim().isEmpty || socketChannel == null) return;

    final messageText = messageTEC.text.trim();

    // Create message object to send
    final messageData = json.encode({
      'type': 'chat_message',
      'message': messageText,
      'sender_id': currentUserId,
      'timestamp': DateTime.now().toIso8601String(),
    });

    try {
      // Send message through WebSocket
      socketChannel!.sink.add(messageData);

      // Add to local messages immediately for better UX
      messages.add(ChatMessage(
        text: messageText,
        isMe: true,
        timestamp: DateTime.now(),
        senderId: currentUserId,
      ));

      // Clear input
      messageTEC.clear();

      // Scroll to bottom
      _scrollToBottom();
    } catch (e) {
      print('Error sending message: $e');
      Get.snackbar(
        'Error',
        'Failed to send message',
        snackPosition: SnackPosition.BOTTOM,
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